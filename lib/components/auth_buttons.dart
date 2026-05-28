import 'package:budget/app_colors.dart';
import 'package:budget/components/email_field.dart';
import 'package:budget/components/open_sans.dart';
import 'package:budget/components/password_field.dart';
import 'package:budget/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/create_button.dart';

class AuthButtons extends HookConsumerWidget {
  const AuthButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ViewModel viewModelProvider = ref.watch(viewModel);

    return Column(
      children: [
        Row(
          mainAxisAlignment: .center,
          children: [
            SizedBox(
              height: 50,
              width: 150,
              child: MaterialButton(
                splashColor: Colors.grey,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () async {
                  await viewModelProvider.createUser(
                    context,
                    emailField.text,
                    passwordField.text,
                  );
                },
                child: OpenSans(
                  text: "Register",
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(
              "Or ",
              style: GoogleFonts.pacifico(
                fontSize: 25,
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(width: 20),

            //login button
            SizedBox(
              width: 150,
              height: 50,
              child: MaterialButton(
                splashColor: Colors.grey,
                color: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () async {
                  await viewModelProvider.loginUser(
                    context,
                    emailField.text,
                    passwordField.text,
                  );
                },
                child: OpenSans(
                  text: "Login",
                  size: 25,
                  color: AppColors.surfaceColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),

        //Google signin
        SignInButton(
          buttonType: .google,
          btnColor: AppColors.secondaryColor,
          btnTextColor: Colors.white,
          buttonSize: .medium,
          onPressed: () async {
            if (kIsWeb) {
              await viewModelProvider.webGoogleSignIn(context);
            } else {
              await viewModelProvider.mobileGoogleSignIn(context);
            }
          },
        ),
      ],
    );
  }
}
