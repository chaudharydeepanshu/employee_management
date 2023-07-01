import 'package:employee_management/features/dashboard/domain/models/employees_model.dart';
import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';
import 'package:employee_management/features/shared/presentation/commands/base_command.dart';
import 'package:employee_management/features/shared/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:employee_management/features/shared/presentation/widgets/snackbars/info_snackbar.dart';
import 'package:employee_management/utils/logger_util.dart';

/// A command class responsible for adding employee.
///
/// This command updates the employees model with the updated employees.
class AddEmployeeCommand extends BaseCommand {
  /// Creates an instance of [AddEmployeeCommand].
  AddEmployeeCommand();

  /// Runs the command.
  Future<void> run(EmployeeModel employee) async {
    EmployeesModel employeesModel = employeesModelCubit.state;

    showInfoSnackBar(text: 'Adding employee data...');

    // Update the employees model with the new employees.
    EmployeesModel updatedModel = employeesModel.copyWith(
      employees: <EmployeeModel>[...employeesModel.employees, employee],
    );

    employeesModelCubit.updateModel(updatedModel);

    try {
      await employeeService.addEmployee(employee);

      showInfoSnackBar(text: 'Employee data has been added');
    } catch (e) {
      logger.e(e);
      employeesModelCubit.updateModel(employeesModel);

      showErrorSnackBar(
        text: 'Failed to add employee data',
        subText: e.toString(),
      );
    }
  }
}
