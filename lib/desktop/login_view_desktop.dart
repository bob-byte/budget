import 'package:budget/app_constants.dart';
import 'package:budget/components/auth_buttons.dart';
import 'package:budget/components/email_field.dart';
import 'package:budget/components/open_sans.dart';
import 'package:budget/components/password_field.dart';
import 'package:budget/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/create_button.dart';

class LoginViewDesktop extends HookConsumerWidget {
  const LoginViewDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailField = useTextEditingController();
    TextEditingController passwordField = useTextEditingController();

    final ViewModel viewModelProvider = ref.watch(viewModel);
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: .spaceAround,
          crossAxisAlignment: .center,
          children: [
            Image.asset(
              "assets/login.png",
              fit: BoxFit.contain,
              width: deviceWidth / 2.6,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  SizedBox(height: deviceHeight / 5.5),
                  Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                    width: 200,
                  ),
                  SizedBox(height: 40),
                  EmailField(),
                  SizedBox(height: 20),

                  //Password
                  PasswordField(),
                  SizedBox(height: 30),
                  AuthButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
