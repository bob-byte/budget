import 'package:budget/app_colors.dart';
import 'package:budget/components/sans_bold.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  static Future<void> success(
    BuildContext context,
    String title,
    String content,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: SansBold(text: title, size: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: SansBold(
                text: "OK",
                size: 16,
                textColor: AppColors.secondaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> error(
    BuildContext context,
    String content,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: SansBold(text: "Error", size: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColors.errorColor, width: 2),
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: SansBold(
                text: "OK",
                size: 16,
                textColor: AppColors.secondaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
