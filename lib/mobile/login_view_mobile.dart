import 'package:budget/app_constants.dart';
import 'package:budget/components/auth_buttons.dart';
import 'package:budget/components/email_field.dart';
import 'package:budget/components/open_sans.dart';
import 'package:budget/components/password_field.dart';
import 'package:budget/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/sign_button.dart';

class LoginViewMobile extends HookConsumerWidget {
  const LoginViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailField = useTextEditingController();
    TextEditingController passwordField = useTextEditingController();

    final ViewModel viewModelProvider = ref.watch(viewModel);
    final double deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .center,
            children: [
              SizedBox(height: deviceHeight / 5.5),
              Image.asset("assets/logo.png", fit: BoxFit.contain, width: 210),
              SizedBox(height: 10),
              EmailField(),
              SizedBox(height: 20),
              PasswordField(),
              SizedBox(height: 30),
              AuthButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
