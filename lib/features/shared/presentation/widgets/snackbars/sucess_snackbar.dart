import 'package:employee_management/features/shared/presentation/widgets/snackbars/custom_snackbar.dart';
import 'package:employee_management/theme/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:employee_management/main.dart';

/// A custom snackbar used to show success.
ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showSuccessSnackBar({
  required String text,
  String? subText,
}) {
  BuildContext? context = rootScaffoldMessengerKey.currentContext;

  if (context != null) {
    final ThemeData theme = Theme.of(context);

    return showCustomSnackBar(
      text: text,
      subText: subText,
      iconData: Icons.check_circle,
      // Using custom colors.
      iconAndTextColor: theme.extension<CustomColors>()!.successColor,
    );
  } else {
    return null;
  }
}
