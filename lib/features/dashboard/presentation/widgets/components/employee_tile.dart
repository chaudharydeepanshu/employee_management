import 'package:flutter/material.dart';
import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';
import 'package:employee_management/utils/date_time_util.dart';

/// Widget for employee tile.
class EmployeeTile extends StatefulWidget {
  /// Creates an instance of [EmployeeTile].
  const EmployeeTile({
    Key? key,
    required this.index,
    required this.name,
    required this.joinDateTime,
    required this.endDateTime,
    required this.role,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  /// The index of the item.
  final int index;

  /// The employee name.
  final String name;

  /// The employee joining date.
  final DateTime joinDateTime;

  /// The employee end date.
  final DateTime? endDateTime;

  /// The employee role.
  final RoleType role;

  /// The onEdit callback.
  final void Function()? onEdit;

  /// The onDelete callback.
  final void Function()? onDelete;

  @override
  State<EmployeeTile> createState() => _EmployeeTileState();
}

class _EmployeeTileState extends State<EmployeeTile> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: widget.onEdit,
      child: ListTile(
        title: Text(
          widget.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getRoleTypeLabel(widget.role),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: theme.colorScheme.outline,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                widget.endDateTime == null
                    ? 'From ${getDateInddMMMyyyyFormat(widget.joinDateTime)}'
                    : '${getDateInddMMMyyyyFormat(widget.joinDateTime)} - '
                        '${getDateInddMMMyyyyFormat(widget.endDateTime!)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: theme.colorScheme.outline,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
