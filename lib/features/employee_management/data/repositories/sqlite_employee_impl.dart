import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:employee_management/features/employee_management/data/repositories/employee_repository.dart';
import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';

/// A implementation class of [EmployeeRepository] for sqlite database.
class SQLiteEmployeeImpl implements EmployeeRepository {
  late Database _database;

  Future<void> _openDatabase() async {
    // Use path_provider to get the right location for the database.

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = appDocDir.path;

    _database = await openDatabase(
      '$databasePath/employee_management.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE employees(
              uuid TEXT PRIMARY KEY,
              name TEXT,
              joinDateTime INTEGER,
              endDateTime INTEGER NULL,
              role INTEGER
            )
          ''');
      },
    );
  }

  Map<String, dynamic> _toJson(EmployeeModel employee) {
    return <String, dynamic>{
      'uuid': employee.uuid,
      'name': employee.name,
      'joinDateTime': employee.joinDateTime.millisecondsSinceEpoch,
      'endDateTime': employee.endDateTime?.millisecondsSinceEpoch,
      'role': employee.role.index, // Convert enum to int (index)
    };
  }

  EmployeeModel _fromJson(Map<String, dynamic> map) {
    return EmployeeModel(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      joinDateTime:
          DateTime.fromMillisecondsSinceEpoch(map['joinDateTime'] as int),
      endDateTime: map['endDateTime'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['endDateTime'] as int),
      role: RoleType.values[map['role'] as int], // Convert int to enum
    );
  }

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    await _openDatabase();
    final List<Map<String, dynamic>> maps = await _database.query('employees');
    return List<EmployeeModel>.generate(maps.length, (int index) {
      return _fromJson(maps[index]); // Use fromJson here
    });
  }

  @override
  Future<void> addEmployee(EmployeeModel employee) async {
    await _openDatabase();

    // /// use a test list employeeList for adding employees
    // for (EmployeeModel employee in employeeList) {
    //   await _database.insert(
    //     'employees',
    //     _toJson(employee),
    //     conflictAlgorithm: ConflictAlgorithm.replace,
    //   );
    // }

    await _database.insert(
      'employees',
      _toJson(employee),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateEmployee(EmployeeModel employee) async {
    await _openDatabase();
    await _database.update(
      'employees',
      _toJson(employee),
      where: 'uuid = ?',
      whereArgs: <String>[employee.uuid],
    );
  }

  @override
  Future<void> deleteEmployee(String uuid) async {
    await _openDatabase();
    await _database.delete(
      'employees',
      where: 'uuid = ?',
      whereArgs: <String>[uuid],
    );
  }
}
