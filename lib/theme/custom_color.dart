// ignore_for_file: public_member_api_docs

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const Color successColor = Color(0xFF00A28E);
const Color warningColor = Color(0xFFF18C33);

CustomColors lightCustomColors = const CustomColors(
  sourceSuccessColor: Color(0xFF00A28E),
  successColor: Color(0xFF006B5D),
  onSuccessColor: Color(0xFFFFFFFF),
  successColorContainer: Color(0xFF77F8E0),
  onSuccessColorContainer: Color(0xFF00201B),
  sourceWarningColor: Color(0xFFF18C33),
  warningColor: Color(0xFF924C00),
  onWarningColor: Color(0xFFFFFFFF),
  warningColorContainer: Color(0xFFFFDCC4),
  onWarningColorContainer: Color(0xFF2F1400),
);

CustomColors darkCustomColors = const CustomColors(
  sourceSuccessColor: Color(0xFF00A28E),
  successColor: Color(0xFF57DBC4),
  onSuccessColor: Color(0xFF003730),
  successColorContainer: Color(0xFF005046),
  onSuccessColorContainer: Color(0xFF77F8E0),
  sourceWarningColor: Color(0xFFF18C33),
  warningColor: Color(0xFFFFB781),
  onWarningColor: Color(0xFF4E2600),
  warningColorContainer: Color(0xFF6F3800),
  onWarningColorContainer: Color(0xFFFFDCC4),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceSuccessColor,
    required this.successColor,
    required this.onSuccessColor,
    required this.successColorContainer,
    required this.onSuccessColorContainer,
    required this.sourceWarningColor,
    required this.warningColor,
    required this.onWarningColor,
    required this.warningColorContainer,
    required this.onWarningColorContainer,
  });

  final Color? sourceSuccessColor;
  final Color? successColor;
  final Color? onSuccessColor;
  final Color? successColorContainer;
  final Color? onSuccessColorContainer;
  final Color? sourceWarningColor;
  final Color? warningColor;
  final Color? onWarningColor;
  final Color? warningColorContainer;
  final Color? onWarningColorContainer;

  @override
  CustomColors copyWith({
    Color? sourceSucesscolor,
    Color? sucesscolor,
    Color? onSucesscolor,
    Color? sucesscolorContainer,
    Color? onSucesscolorContainer,
    Color? sourceWarningcolor,
    Color? warningcolor,
    Color? onWarningcolor,
    Color? warningcolorContainer,
    Color? onWarningcolorContainer,
  }) {
    return CustomColors(
      sourceSuccessColor: sourceSucesscolor ?? sourceSuccessColor,
      successColor: sucesscolor ?? successColor,
      onSuccessColor: onSucesscolor ?? onSuccessColor,
      successColorContainer: sucesscolorContainer ?? successColorContainer,
      onSuccessColorContainer:
          onSucesscolorContainer ?? onSuccessColorContainer,
      sourceWarningColor: sourceWarningcolor ?? sourceWarningColor,
      warningColor: warningcolor ?? warningColor,
      onWarningColor: onWarningcolor ?? onWarningColor,
      warningColorContainer: warningcolorContainer ?? warningColorContainer,
      onWarningColorContainer:
          onWarningcolorContainer ?? onWarningColorContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceSuccessColor:
          Color.lerp(sourceSuccessColor, other.sourceSuccessColor, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      onSuccessColor: Color.lerp(onSuccessColor, other.onSuccessColor, t),
      successColorContainer:
          Color.lerp(successColorContainer, other.successColorContainer, t),
      onSuccessColorContainer:
          Color.lerp(onSuccessColorContainer, other.onSuccessColorContainer, t),
      sourceWarningColor:
          Color.lerp(sourceWarningColor, other.sourceWarningColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
      onWarningColor: Color.lerp(onWarningColor, other.onWarningColor, t),
      warningColorContainer:
          Color.lerp(warningColorContainer, other.warningColorContainer, t),
      onWarningColorContainer:
          Color.lerp(onWarningColorContainer, other.onWarningColorContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceSuccessColor]
  ///   * [CustomColors.successColor]
  ///   * [CustomColors.onSuccessColor]
  ///   * [CustomColors.successColorContainer]
  ///   * [CustomColors.onSuccessColorContainer]
  ///   * [CustomColors.sourceWarningColor]
  ///   * [CustomColors.warningColor]
  ///   * [CustomColors.onWarningColor]
  ///   * [CustomColors.warningColorContainer]
  ///   * [CustomColors.onWarningColorContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceSucesscolor: sourceSuccessColor!.harmonizeWith(dynamic.primary),
      sucesscolor: successColor!.harmonizeWith(dynamic.primary),
      onSucesscolor: onSuccessColor!.harmonizeWith(dynamic.primary),
      sucesscolorContainer:
          successColorContainer!.harmonizeWith(dynamic.primary),
      onSucesscolorContainer:
          onSuccessColorContainer!.harmonizeWith(dynamic.primary),
      sourceWarningcolor: sourceWarningColor!.harmonizeWith(dynamic.primary),
      warningcolor: warningColor!.harmonizeWith(dynamic.primary),
      onWarningcolor: onWarningColor!.harmonizeWith(dynamic.primary),
      warningcolorContainer:
          warningColorContainer!.harmonizeWith(dynamic.primary),
      onWarningcolorContainer:
          onWarningColorContainer!.harmonizeWith(dynamic.primary),
    );
  }
}
