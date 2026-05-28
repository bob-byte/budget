import 'package:flutter/material.dart';

class AppColors {
  // Private constructor prevents instantiation
  AppColors._();

  // Color palette
  static const Color primaryColor = Colors.white;
  static const Color secondaryColor = Colors.black;
  static const Color surfaceColor = Colors.white;
  static const Color accentColor = Colors.teal;
  static const Color errorColor = Colors.red;

  /// Neutral UI (Experience, cards, borders). Use with [surfaceColor] and [secondaryColor].
  static const Color scaffoldBackgroundColor = Color(0xFFF3F4F6);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color textMutedColor = Color(0xFF6B7280);
  static const Color chipBackgroundColor = Color(0xFFF9FAFB);
  static const Color panelMutedColor = Color(0xFFFAFAFA);
  static const Color linkColor = Color(0xFF2563EB);
}
