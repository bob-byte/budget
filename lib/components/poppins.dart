import 'dart:ui';

import 'package:budget/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Poppins extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight? fontWeight;

  const Poppins({
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
      style: GoogleFonts.poppins(
        fontSize: size,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.secondaryColor,
      ),
    );
  }
}
