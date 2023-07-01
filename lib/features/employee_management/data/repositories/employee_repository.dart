import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';

/// Interface for employee repository
abstract class EmployeeRepository {
  /// Get all employees.
  Future<List<EmployeeModel>> getEmployees();

  /// Add employee.
  Future<void> addEmployee(EmployeeModel employee);

  /// Update employee.
  Future<void> updateEmployee(EmployeeModel employee);

  /// Delete employee.
  Future<void> deleteEmployee(String uuid);
}
