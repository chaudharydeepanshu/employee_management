import 'package:employee_management/features/dashboard/domain/models/employees_model.dart';
import 'package:employee_management/features/shared/presentation/commands/base_command.dart';
import 'package:employee_management/features/shared/presentation/widgets/logs_dialog.dart';
import 'package:employee_management/features/shared/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:employee_management/features/shared/presentation/widgets/snackbars/info_snackbar.dart';
import 'package:employee_management/main.dart';
import 'package:employee_management/utils/logger_util.dart';
import 'package:flutter/material.dart';

/// A command class responsible for loading employees.
///
/// This command updates the employees model with the loaded employees.
class LoadEmployeesCommand extends BaseCommand {
  /// Creates an instance of [LoadEmployeesCommand].
  LoadEmployeesCommand();

  /// Runs the command.
  Future<void> run() async {
    showInfoSnackBar(text: 'Loading employees data...');

    EmployeesModel employeesModel;

    try {
      employeesModel = EmployeesModel(
        employees: await employeeService.getEmployees(),
      );

      employeesModelCubit.updateModel(employeesModel);

      showInfoSnackBar(text: 'Employees data has been loaded');
    } catch (e, stackTrace) {
      logger.e(e);

      showErrorSnackBar(
        text: 'Failed to load employees data',
        subText: e.toString(),
        action: SnackBarAction(
          label: 'Logs',
          onPressed: () async {
            await showLogsDialog(
              stackTrace,
            );
            rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      );
    }
  }
}
