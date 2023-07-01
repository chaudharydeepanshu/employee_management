import 'package:employee_management/features/employee_management/data/repositories/employee_repository.dart';
import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';

/// A service class responsible for managing the employees.
class EmployeeService {
  /// Creates an instance of [EmployeeService].
  EmployeeService(this._employeeRepository);

  final EmployeeRepository _employeeRepository;

  /// Get all employees.
  Future<List<EmployeeModel>> getEmployees() async {
    return _employeeRepository.getEmployees();
  }

  /// Add employee.
  Future<void> addEmployee(EmployeeModel employee) async {
    return _employeeRepository.addEmployee(employee);
  }

  /// Update employee.
  Future<void> updateEmployee(EmployeeModel employee) async {
    return _employeeRepository.updateEmployee(employee);
  }

  /// Delete employee.
  Future<void> deleteEmployee(String uuid) async {
    return _employeeRepository.deleteEmployee(uuid);
  }
}
