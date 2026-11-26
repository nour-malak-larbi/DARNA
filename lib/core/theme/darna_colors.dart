import 'package:flutter/material.dart';

/// Design color tokens extracted from the Darna Figma UI kit.
abstract final class DarnaColors {
  static const Color background = Color(0xFFF7F3E9);
  static const Color ivory = Color(0xFFF7F3E8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0E3DA);
  static const Color mutedGold = Color(0xFFD4AF37);

  static const Color primary = Color(0xFF0F4D46);
  static const Color primaryGradientEnd = Color(0xFF1A6459);
  static const Color primaryPressed = Color(0xFF0F4D46);
  static const Color secondaryPressed = Color(0xFF183A2B);
  static const Color navActive = Color(0xFF254C3B);

  static const Color sageTint = Color(0xFFDCE7D8);
  static const Color disabledSurface = Color(0xFFD9DED5);

  static const Color textPrimary = Color(0xFF262E29);
  static const Color textSecondary = Color(0xFF626B64);

  // Semantic status & alert colors
  static const Color successBackground = Color(0xFFEAF2EA);
  static const Color successForeground = Color(0xFF245D40);

  static const Color errorBackground = Color(0xFFFAEBE8);
  static const Color errorForeground = Color(0xFFA43732);

  static const Color warningBackground = Color(0xFFF5EADC);
  static const Color warningForeground = Color(0xFF805421);

  static const Color infoBackground = Color(0xFFEAF0F4);
  static const Color infoForeground = Color(0xFF345A71);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [primary, primaryGradientEnd],
  );

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x08262E29), // rgba(38, 46, 41, 0.03)
      blurRadius: 12,
      offset: Offset(0, 3),
    ),
  ];
}
