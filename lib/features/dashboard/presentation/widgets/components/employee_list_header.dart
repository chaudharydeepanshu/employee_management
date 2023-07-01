import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';
import 'package:flutter/material.dart';

/// Widget for the header of the list of employees.
class EmployeeListHeader extends StatelessWidget {
  /// Creates an instance of [EmployeeListHeader].
  const EmployeeListHeader({
    super.key,
    required this.title,
    required this.employees,
  });

  /// The title of the list.
  final String title;

  /// The employees list.
  final List<EmployeeModel> employees;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return employees.isNotEmpty
        ? SliverToBoxAdapter(
            child: Container(
              color: theme.colorScheme.surfaceVariant,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        : const SliverToBoxAdapter();
  }
}
