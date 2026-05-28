import 'package:budget/app_colors.dart';
import 'package:budget/components/add_expense_button.dart';
import 'package:budget/components/add_income_button.dart';
import 'package:budget/components/drawer_expense.dart';
import 'package:budget/components/open_sans.dart';
import 'package:budget/components/poppins.dart';
import 'package:budget/components/total_calculations.dart';
import 'package:budget/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

bool isLoading = true;

class ExpensiveViewMobile extends HookConsumerWidget {
  const ExpensiveViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    final double deviceWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      viewModelProvider.expensesStream();
      viewModelProvider.incomesStream();
      isLoading = false;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primaryColor, size: 30),
          backgroundColor: AppColors.secondaryColor,
          centerTitle: true,
          title: Poppins(
            text: "Dashboard",
            size: 20,
            color: AppColors.primaryColor,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await viewModelProvider.reset();
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        drawer: DrawerExpense(),
        body: ListView(
          children: [
            SizedBox(height: 40),
            Column(
              children: [
                Container(
                  height: 240,
                  width: deviceWidth / 1.5,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TotalCalculations(size: 14),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                AddExpenseButton(),
                SizedBox(width: 10),
                AddIncomeButton(),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .start,
                children: [
                  //Expense list
                  Column(
                    children: [
                      OpenSans(text: "Expenses", size: 15),
                      Container(
                        padding: EdgeInsets.all(7),
                        height: 210,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                            width: 1,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: viewModelProvider.expenses.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Poppins(
                                  text: viewModelProvider.expenses[index].name,
                                  size: 12,
                                ),
                                Align(
                                  alignment: .centerRight,
                                  child: Poppins(
                                    text: viewModelProvider
                                        .expenses[index]
                                        .amount,
                                    size: 12,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  //Income list
                  Column(
                    children: [
                      OpenSans(text: "Incomes", size: 15),
                      Container(
                        padding: EdgeInsets.all(7),
                        height: 210,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                            width: 1,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: viewModelProvider.incomes.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Poppins(
                                  text: viewModelProvider.incomes[index].name,
                                  size: 12,
                                ),
                                Align(
                                  alignment: .centerRight,
                                  child: Poppins(
                                    text:
                                        viewModelProvider.incomes[index].amount,
                                    size: 12,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
