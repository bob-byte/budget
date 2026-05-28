import 'package:budget/app_colors.dart';
import 'package:budget/components/open_sans.dart';
import 'package:budget/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddIncomeButton extends HookConsumerWidget {
  const AddIncomeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ViewModel viewModelProvider = ref.watch(viewModel);

    return SizedBox(
      height: 45,
      width: 160,
      child: MaterialButton(
        onPressed: () async {
          await viewModelProvider.addIncome(context);
        },
        splashColor: AppColors.splashColor,
        color: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          children: [
            Icon(Icons.add, color: AppColors.primaryColor),
            OpenSans(
              text: "Add Income",
              size: 17,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
