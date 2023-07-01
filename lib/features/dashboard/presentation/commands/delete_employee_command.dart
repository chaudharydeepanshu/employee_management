import 'package:employee_management/features/shared/presentation/widgets/logs_dialog.dart';
import 'package:flutter/material.dart';
import 'package:employee_management/features/dashboard/domain/models/employees_model.dart';
import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';
import 'package:employee_management/features/shared/presentation/commands/base_command.dart';
import 'package:employee_management/features/shared/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:employee_management/features/shared/presentation/widgets/snackbars/info_snackbar.dart';
import 'package:employee_management/main.dart';
import 'package:employee_management/utils/logger_util.dart';

/// A command class responsible for deleting employees.
///
/// This command updates the employees model with the updated employees.
class DeleteEmployeeCommand extends BaseCommand {
  /// Creates an instance of [DeleteEmployeeCommand].
  DeleteEmployeeCommand();

  /// Runs the command.
  Future<void> run(String uuid) async {
    EmployeesModel employeeModel = employeesModelCubit.state;

    showInfoSnackBar(text: 'Deleting employee data...');

    // Update the employees model without the deleted employees.
    EmployeesModel updatedModel = employeeModel.copyWith(
      employees: employeeModel.employees
          .where((EmployeeModel element) => element.uuid != uuid)
          .toList(),
    );

    employeesModelCubit.updateModel(updatedModel);

    try {
      await employeeService.deleteEmployee(
        uuid,
      );

      showInfoSnackBar(
        text: 'Employee data has been deleted',
        snackBarAction: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Re-add the deleted employee data.
            employeesModelCubit.updateModel(employeeModel);
            rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      );
    } catch (e, stackTrace) {
      logger.e(e);
      employeesModelCubit.updateModel(employeeModel);

      showErrorSnackBar(
        text: 'Failed to delete employee data',
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
