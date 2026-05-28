import 'package:budget/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenSans extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight? fontWeight;

  const OpenSans({
    super.key,
    required this.text,
    required this.size,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size,
        color: color ?? AppColors.secondaryColor,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
