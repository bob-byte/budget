import 'package:budget/components/poppins.dart';
import 'package:budget/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TotalCalculations extends HookConsumerWidget {
  final double size;
  const TotalCalculations({super.key, required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ViewModel viewModelProvider = ref.watch(viewModel);

    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: .spaceEvenly,
          crossAxisAlignment: .start,
          children: [
            Poppins(text: "Budget left", size: size, color: Colors.white),
            Poppins(text: "Total expense", size: size, color: Colors.white),
            Poppins(text: "Total income", size: size, color: Colors.white),
          ],
        ),
        RotatedBox(
          quarterTurns: 1,
          child: Divider(indent: 40, endIndent: 40, color: Colors.grey),
        ),
        Column(
          mainAxisAlignment: .spaceEvenly,
          crossAxisAlignment: .start,
          children: [
            Poppins(
              text: viewModelProvider.budgetLeft.toString(),
              size: size,
              color: Colors.white,
            ),
            Poppins(
              text: viewModelProvider.totalExpense.toString(),
              size: size,
              color: Colors.white,
            ),
            Poppins(
              text: viewModelProvider.totalIncome.toString(),
              size: size,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
