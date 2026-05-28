import 'package:budget/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final emailField = TextEditingController();

class EmailField extends HookConsumerWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        keyboardType: .emailAddress,
        textAlign: .start,
        controller: emailField,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: "Email",
          hintStyle: TextStyle(color: AppColors.hintColor),
          prefixIcon: Icon(
            Icons.email,
            color: AppColors.secondaryColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
