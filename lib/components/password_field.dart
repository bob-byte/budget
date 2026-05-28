import 'package:budget/app_colors.dart';
import 'package:budget/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final passwordField = TextEditingController();

class PasswordField extends HookConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ViewModel viewModelProvider = ref.watch(viewModel);
    
    return SizedBox(
      width: 350,
      child: TextFormField(
        textAlign: .start,
        controller: passwordField,
        obscureText: viewModelProvider.isObscure,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: "Password",
          hintStyle: const TextStyle(color: AppColors.hintColor),
          prefixIcon: IconButton(
            onPressed: () {
              viewModelProvider.toggleObscure();
            },
            icon: Icon(
              viewModelProvider.isObscure
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: AppColors.secondaryColor,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
