import 'package:budget/app_colors.dart';
import 'package:budget/components/open_sans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextForm extends StatelessWidget {
  final String text;
  final double containerWidth;
  final String hintText;
  final TextEditingController controller;
  final bool digitsOnly;
  final FormFieldValidator<String>? validator;

  const TextForm({
    super.key,
    required this.text,
    required this.containerWidth,
    required this.hintText,
    required this.controller,
    this.digitsOnly = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        OpenSans(text: text, size: 13),
        SizedBox(height: 5),
        SizedBox(
          width: containerWidth,
          child: TextFormField(
            validator: validator,
            inputFormatters: digitsOnly
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            controller: controller,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.errorColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.errorColor),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.accentColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.tealAccentColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
