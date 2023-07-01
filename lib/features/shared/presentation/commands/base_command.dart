import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_management/features/employee_management/presentation/states/employees_state.dart';
import 'package:employee_management/features/employee_management/application/services/employee_service.dart';

late BuildContext _mainContext;

/// Initialize the [BaseCommand] with the [BuildContext]l.
void init(BuildContext c) => _mainContext = c;

/// Provide quick lookup methods for all the top-level models and services.
class BaseCommand {
  /// [EmployeesModelCubit] global instance.
  EmployeesModelCubit employeesModelCubit = _mainContext.read();

  /// [EmployeeService] global instance.
  EmployeeService employeeService = _mainContext.read();
}
