import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'darna_colors.dart';

/// Application theme and typography configured with Manrope and Darna tokens.
abstract final class DarnaTheme {
  static ThemeData get light {
    final manrope = GoogleFonts.manrope();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: DarnaColors.background,
      fontFamily: manrope.fontFamily,
      colorScheme: const ColorScheme.light(
        primary: DarnaColors.primary,
        onPrimary: Colors.white,
        secondary: DarnaColors.navActive,
        onSecondary: Colors.white,
        surface: DarnaColors.surface,
        onSurface: DarnaColors.textPrimary,
        error: DarnaColors.errorForeground,
        onError: Colors.white,
        outline: DarnaColors.border,
      ),
      textTheme: TextTheme(
        headlineMedium: manrope.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: DarnaColors.textPrimary,
          height: 1.5,
        ),
        titleLarge: manrope.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: DarnaColors.textPrimary,
          height: 1.5,
        ),
        titleMedium: manrope.copyWith(
          fontSize: 19,
          fontWeight: FontWeight.w600,
          color: DarnaColors.textPrimary,
        ),
        bodyLarge: manrope.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: DarnaColors.textPrimary,
        ),
        bodyMedium: manrope.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: DarnaColors.textPrimary,
          height: 1.5,
        ),
        bodySmall: manrope.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: DarnaColors.textSecondary,
          height: 1.5,
        ),
        labelLarge: manrope.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: manrope.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: DarnaColors.textPrimary,
        ),
        labelSmall: manrope.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerColor: DarnaColors.border,
    );
  }
}
