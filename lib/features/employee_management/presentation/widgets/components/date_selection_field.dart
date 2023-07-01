import 'package:flutter/material.dart';

/// A [TextFormField] for date selection.
class DateSelectionField extends StatelessWidget {
  /// Defining [DateSelectionField] constructor.
  const DateSelectionField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.onTap,
  });

  /// Input decoration label text.
  final String labelText;

  /// Input decoration prefix icon.
  final IconData prefixIcon;

  /// [TextEditingController] for [TextFormField].
  final TextEditingController controller;

  /// [TextFormField] validator.
  final String? Function(String?)? validator;

  /// [TextFormField] onTap.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
      ),
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
