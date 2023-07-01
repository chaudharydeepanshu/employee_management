import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';

/// A list of employees for testing.
final List<EmployeeModel> employeeList = <EmployeeModel>[
  EmployeeModel(
    uuid: "1",
    name: "Drako Malfoy",
    joinDateTime: DateTime.now(),
    endDateTime: DateTime.now().add(const Duration(days: 30)),
    role: RoleType.productDesigner,
  ),
  EmployeeModel(
    uuid: "2",
    name: "Harry Potter",
    joinDateTime: DateTime.now(),
    endDateTime: DateTime.now().add(const Duration(days: 25)),
    role: RoleType.flutterDeveloper,
  ),
  EmployeeModel(
    uuid: "3",
    name: "Hermione Granger",
    joinDateTime: DateTime.now(),
    endDateTime: DateTime.now().add(const Duration(days: 15)),
    role: RoleType.flutterDeveloper,
  ),
  EmployeeModel(
    uuid: "4",
    name: "Ron Weasley",
    joinDateTime: DateTime.now(),
    endDateTime: DateTime.now().add(const Duration(days: 50)),
    role: RoleType.productDesigner,
  ),
  EmployeeModel(
    uuid: "5",
    name: "Albus Dumbledore",
    joinDateTime: DateTime.now(),
    endDateTime: DateTime.now().add(const Duration(days: 14)),
    role: RoleType.qaTester,
  ),
  EmployeeModel(
    uuid: "6",
    name: "Severus Snape",
    joinDateTime: DateTime(2018, 10, 15),
    endDateTime: DateTime(2021, 10, 25),
    role: RoleType.flutterDeveloper,
  ),
  EmployeeModel(
    uuid: "7",
    name: "Rubeus Hagrid",
    joinDateTime: DateTime(2018, 10, 17),
    endDateTime: DateTime(2021, 10, 30),
    role: RoleType.qaTester,
  ),
  EmployeeModel(
    uuid: "8",
    name: "Sirius Black",
    joinDateTime: DateTime(2018, 10, 10),
    endDateTime: DateTime(2021, 10, 10),
    role: RoleType.productDesigner,
  ),
];
