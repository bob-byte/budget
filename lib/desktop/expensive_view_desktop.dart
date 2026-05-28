import 'package:budget/app_colors.dart';
import 'package:budget/components/add_expense_button.dart';
import 'package:budget/components/add_income_button.dart';
import 'package:budget/components/drawer_expense.dart';
import 'package:budget/components/poppins.dart';
import 'package:budget/components/total_calculations.dart';
import 'package:budget/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

bool isLoading = true;

class ExpensiveViewDesktop extends HookConsumerWidget {
  const ExpensiveViewDesktop({super.key});

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
          iconTheme: IconThemeData(color: AppColors.primaryColor, size: 35),
          backgroundColor: AppColors.secondaryColor,
          centerTitle: true,
          title: Poppins(
            text: "Dashboard",
            size: 30,
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
            SizedBox(height: 50),
            //image + addIncome+total calculations
            Row(
              mainAxisAlignment: .spaceEvenly,
              crossAxisAlignment: .start,
              children: [
                Image.asset(
                  "assets/login.png",
                  fit: BoxFit.contain,
                  width: deviceWidth / 2.6,
                ),
                //Add income & expense
                SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      AddExpenseButton(),
                      SizedBox(height: 30),
                      AddIncomeButton(),
                    ],
                  ),
                ),
                SizedBox(width: 30),

                ///total calculations
                Container(
                  height: 300,
                  width: 280,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: TotalCalculations(size: 17),
                ),
              ],
            ),
            SizedBox(height: 40),
            Divider(
              indent: deviceWidth / 4,
              endIndent: deviceWidth / 4,
              thickness: 3,
            ),
            SizedBox(height: 50),

            //Expense & income list
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                //Expenses
                Container(
                  height: 320,
                  width: 260,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    children: [
                      //Expenses heading
                      Center(
                        child: Poppins(
                          text: "Expenses",
                          size: 25,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Divider(
                        indent: 30,
                        endIndent: 30,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 15),

                      Container(
                        padding: EdgeInsets.all(10),
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          border: Border.all(
                            width: 1,
                            color: AppColors.primaryColor,
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
                                  size: 15,
                                  color: AppColors.primaryColor,
                                ),
                                Align(
                                  alignment: .centerRight,
                                  child: Poppins(
                                    text: viewModelProvider
                                        .expenses[index]
                                        .amount,
                                    size: 15,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                //Incomes
                Container(
                  height: 320,
                  width: 260,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    children: [
                      //Incomes heading
                      Center(
                        child: Poppins(
                          text: "Incomes",
                          size: 25,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Divider(
                        indent: 30,
                        endIndent: 30,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 15),

                      Container(
                        padding: EdgeInsets.all(10),
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          border: Border.all(
                            width: 1,
                            color: AppColors.primaryColor,
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
                                  size: 15,
                                  color: AppColors.primaryColor,
                                ),
                                Align(
                                  alignment: .centerRight,
                                  child: Poppins(
                                    text:
                                        viewModelProvider.incomes[index].amount,
                                    size: 15,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
