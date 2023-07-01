import 'package:flutter/material.dart';
import 'package:employee_management/features/employee_management/domain/models/employee_model.dart';

/// Function to show role selection bottom sheet.
Future<RoleType?> showRoleSelectionBottomSheet(
  BuildContext context,
  RoleType? selectedRoleType,
) async {
  await showModalBottomSheet<Widget>(
    context: context,
    builder: (BuildContext context) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: RoleType.values.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 0);
        },
        itemBuilder: (BuildContext context, int index) {
          return RoleTile(
            type: RoleType.values[index],
            onChanged: (RoleType type) {
              selectedRoleType = type;
            },
          );
        },
      );
    },
  );

  return selectedRoleType;
}

/// Widget for role tile.
class RoleTile extends StatelessWidget {
  /// Creates an instance of [RoleTile].
  const RoleTile({super.key, required this.type, required this.onChanged});

  /// The role type.
  final RoleType type;

  /// The onChanged callback.
  final ValueChanged<RoleType> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        getRoleTypeLabel(type),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () {
        onChanged.call(type);
        // Close the bottom sheet after selection.
        Navigator.pop(context);
      },
    );
  }
}
