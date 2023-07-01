import 'package:flutter/material.dart';

/// Returns a custom [ThemeData] based on the [colorScheme].
ThemeData customThemeData({
  required ColorScheme colorScheme,
  Iterable<ThemeExtension<dynamic>>? extensions,
}) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    extensions: extensions,
    fontFamily: 'LexendDeca',
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.outline.withOpacity(0.35),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      isDense: true,
      prefixIconColor: colorScheme.primary,
      suffixIconColor: colorScheme.primary,
    ),
    iconTheme: IconThemeData(
      color: colorScheme.primary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      titleTextStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: colorScheme.onPrimary,
      ),
    ),
    dialogTheme: DialogTheme(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        // only top corners are rounded
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    ),
  );
}
