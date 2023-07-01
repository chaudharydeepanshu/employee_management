import 'package:flutter/material.dart';
import 'package:employee_management/features/shared/presentation/widgets/snackbars/custom_snackbar.dart';
import 'package:employee_management/main.dart';

/// A custom snackbar used to show errors.
ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showErrorSnackBar({
  required String text,
  String? subText,
  required SnackBarAction action,
}) {
  ScaffoldMessengerState? scaffold = rootScaffoldMessengerKey.currentState;

  if (scaffold != null) {
    BuildContext context = scaffold.context;

    final ThemeData theme = Theme.of(context);

    return showCustomSnackBar(
      text: text,
      subText: subText,
      iconData: Icons.cancel,
      iconAndTextColor: theme.colorScheme.error,
      duration: const Duration(seconds: 30),
      action: action,
    );
  } else {
    return null;
  }
}
