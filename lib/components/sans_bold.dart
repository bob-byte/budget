import 'package:budget/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SansBold extends StatelessWidget {
  final String text;
  final double size;
  final Color? textColor;

  const SansBold({super.key, required this.text, required this.size, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(fontSize: size, fontWeight: .bold, color: textColor ?? AppConstants.secondaryColor),
    );
  }
}
