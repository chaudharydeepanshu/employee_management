// create a beautiful log dialog
import 'package:employee_management/main.dart';
import 'package:flutter/material.dart';

/// A function to call log dialog.
Future<void> showLogsDialog(StackTrace stackTrace) async {
  if (rootNavigatorKey.currentState?.context == null) {
    return;
  }
  await showDialog<void>(
    context: rootNavigatorKey.currentState!.context,
    builder: (BuildContext context) {
      return LogsDialog(stackTrace: stackTrace);
    },
  );
}

/// A dialog that displays logs.
class LogsDialog extends StatelessWidget {
  /// Creates an instance of [LogsDialog].
  const LogsDialog({super.key, required this.stackTrace});

  /// The stack trace to display.
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logs'),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).colorScheme.error.withOpacity(0.35),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Text(stackTrace.toString()),
        ),
      ),
      actions: <Widget>[
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
