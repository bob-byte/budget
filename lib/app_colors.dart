import 'package:flutter/material.dart';

class AppColors {
  // Private constructor prevents instantiation
  AppColors._();

  // Core palette
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color secondaryColor = Color(0xFF000000);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFF009688);
  static const Color errorColor = Color(0xFFF44336);
  static const Color splashColor = Color(0xFF9E9E9E);
  static const Color hintColor = Color(0xFF9E9E9E);
  static const Color tealAccentColor = Color(0xFF64FFDA);

  /// Neutral UI (Experience, cards, borders). Use with [surfaceColor] and [secondaryColor].
  static const Color scaffoldBackgroundColor = Color(0xFFF3F4F6);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color textMutedColor = Color(0xFF6B7280);
  static const Color chipBackgroundColor = Color(0xFFF9FAFB);
  static const Color panelMutedColor = Color(0xFFFAFAFA);
  static const Color linkColor = Color(0xFF2563EB);
}
