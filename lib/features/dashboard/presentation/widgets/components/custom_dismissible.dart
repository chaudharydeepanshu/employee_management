import 'package:flutter/material.dart';

/// Widget for a custom [Dismissible] widget.
class CustomDismissible extends StatelessWidget {
  /// Creates an instance of [CustomDismissible].
  const CustomDismissible({
    super.key,
    required this.uuid,
    required this.child,
    this.onDelete,
    this.onDone,
  });

  /// The index of the item.
  final String uuid;

  /// The child widget.
  final Widget child;

  /// The callback function for when the item is deleted.
  final void Function()? onDelete;

  /// The callback function for when the item is marked as done.
  final void Function()? onDone;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Dismissible(
      direction: DismissDirection.endToStart, // Set direction to right-to-left
      key: ValueKey<String>(uuid),
      secondaryBackground: Container(
        color: theme.colorScheme.error,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.delete_outlined,
              color: theme.colorScheme.onError,
            ),
          ),
        ),
      ),
      background: const SizedBox(),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete?.call();
        }
      },
      child: child,
    );
  }
}
