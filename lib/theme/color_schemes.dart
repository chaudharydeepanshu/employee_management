import 'package:flutter/material.dart';

/// Defines a set of colors for light theme.
ColorScheme lightColorScheme =
    ColorScheme.fromSeed(seedColor: Colors.blue).copyWith(
  primary: Colors.blue,
  primaryContainer: Colors.blue.shade50,
  secondary: Colors.blue,
  secondaryContainer: Colors.blue.shade50,
  onSecondaryContainer: Colors.blue,
  surface: Colors.white,
  background: Colors.white,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
);

/// Defines a set of colors for dark theme.
ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,
  brightness: Brightness.dark,
);
