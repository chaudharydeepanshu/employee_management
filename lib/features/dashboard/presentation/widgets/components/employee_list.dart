import 'package:flutter/material.dart';
import 'package:employee_management/features/dashboard/presentation/commands/delete_employee_command.dart';
import 'package:employee_management/features/dashboard/presentation/widgets/components/custom_dismissible.dart';
import 'package:employee_management/features/dashboard/presentation/widgets/components/employee_tile.dart';
import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';
import 'package:employee_management/features/employee_management/presentation/widgets/employee_edit_add_screen.dart';
import 'package:employee_management/route/app_routes.dart' as route;

/// Widget for the list of employees.
class EmployeeList extends StatelessWidget {
  /// Creates an instance of [EmployeeList].
  const EmployeeList({
    super.key,
    required this.employees,
  });

  /// The employees.
  final List<EmployeeModel> employees;

  @override
  Widget build(BuildContext context) {
    /// The function to call when a employee is deleted.
    Future<void> onDelete(int index) async {
      await DeleteEmployeeCommand().run(employees[index].uuid);
    }

    return employees.isNotEmpty
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final Widget tile = EmployeeTile(
                  name: employees[index].name,
                  joinDateTime: employees[index].joinDateTime,
                  endDateTime: employees[index].endDateTime,
                  index: index,
                  role: employees[index].role,
                  onEdit: () {
                    Navigator.pushNamed(
                      context,
                      route.AppRoutes.addEditEmployeeScreen,
                      arguments: AddEditEmployeeScreenArguments(
                        employee: employees[index],
                      ),
                    );
                  },
                  onDelete: () {
                    onDelete(index);
                  },
                );

                // Add separators except for the last item
                return Column(
                  children: <Widget>[
                    CustomDismissible(
                      uuid: employees[index].uuid,
                      onDelete: () {
                        onDelete(index);
                      },
                      child: tile,
                    ),
                    if (index < employees.length - 1) const Divider(height: 0),
                  ],
                );
              },
              childCount: employees.length,
            ),
          )
        : const SliverToBoxAdapter();
  }
}
