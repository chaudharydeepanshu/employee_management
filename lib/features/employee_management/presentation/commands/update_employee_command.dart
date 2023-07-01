import 'package:employee_management/features/dashboard/domain/models/employees_model.dart';
import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';
import 'package:employee_management/features/shared/presentation/commands/base_command.dart';
import 'package:employee_management/features/shared/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:employee_management/features/shared/presentation/widgets/snackbars/info_snackbar.dart';
import 'package:employee_management/utils/logger_util.dart';

/// A command class responsible for updating employees.
///
/// This command updates the employees model with the updated employees.
class UpdateEmployeeCommand extends BaseCommand {
  /// Creates an instance of [UpdateEmployeeCommand].
  UpdateEmployeeCommand();

  /// Runs the command.
  Future<void> run(EmployeeModel employeeModel) async {
    EmployeesModel employeesModel = employeesModelCubit.state;
    showInfoSnackBar(text: 'Updating employee data...');

    // Update the employees model with the updated employees.
    EmployeesModel updatedModel = employeesModel.copyWith(
      //use the employees uuid to find the employees in the list and update it
      employees: employeesModel.employees.map((EmployeeModel element) {
        if (element.uuid == employeeModel.uuid) {
          return employeeModel;
        } else {
          return element;
        }
      }).toList(),
    );

    employeesModelCubit.updateModel(updatedModel);

    try {
      await employeeService.updateEmployee(employeeModel);

      showInfoSnackBar(text: 'Employee data has been updated');
    } catch (e) {
      logger.e(e);
      employeesModelCubit.updateModel(employeesModel);

      showErrorSnackBar(
        text: 'Failed to update employee data',
        subText: e.toString(),
      );
    }
  }
}
