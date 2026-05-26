import 'dart:async';

import 'package:budget/components/app_dialogs.dart';
import 'package:budget/components/open_sans.dart';
import 'package:budget/components/text_form.dart';
import 'package:budget/models/amount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:logger/logger.dart';

final viewModel = ChangeNotifierProvider.autoDispose<ViewModel>(
  (ref) => ViewModel(),
);

class ViewModel extends ChangeNotifier {
  ViewModel() {
    isSignedIn = _auth.currentUser != null;
    _authSubscription = _auth.authStateChanges().listen((User? user) {
      final signedIn = user != null;
      if (isSignedIn == signedIn) return;
      isSignedIn = signedIn;
      notifyListeners();
    });
  }

  List<BudgetEntry> expenses = [];
  List<BudgetEntry> incomes = [];
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;
  final _logger = Logger();
  late final StreamSubscription<User?> _authSubscription;
  bool isSignedIn = false;
  bool isObscure = true;
  int totalExpense = 0;
  int totalIncome = 0;
  int budgetLeft = 0;

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  void toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  //Authentication
  Future<bool> createUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    bool isCreated = false;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.d("User created successfully");
      isCreated = true;
    } catch (e) {
      if (context.mounted) {
        AppDialogs.error(
          context,
          e.toString().replaceAll(RegExp("\\[.*?\\]"), ""),
        );
      }
    }

    return isCreated;
  }

  Future<bool> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    bool isSignedIn = false;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isSignedIn = true;
    } catch (e) {
      if (context.mounted) {
        AppDialogs.error(
          context,
          e.toString().replaceAll(RegExp("\\[.*?\\]"), ""),
        );
      }
    }

    return isSignedIn;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<bool> webGoogleSignIn(BuildContext context) async {
    final googleProvider = GoogleAuthProvider();

    bool isSignedIn = false;

    try {
      await _auth.signInWithPopup(googleProvider);
      _logger.d("Google sign is successful");
      isSignedIn = true;
    } catch (e) {
      if (context.mounted) {
        await AppDialogs.error(
          context,
          e.toString().replaceAll(RegExp("\\[.*?\\]"), ""),
        );
      }
    }

    return isSignedIn;
  }

  Future<bool> mobileGoogleSignIn(BuildContext context) async {
    bool isSignedIn = false;
    try {
      final GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: const ["email"],
      );
      _logger.d("Authentication successful");

      final String? idToken = account.authentication.idToken;
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      await _auth.signInWithCredential(credential);

      _logger.d("Google sign is successful");

      isSignedIn = true;
    } catch (e) {
      if (context.mounted) {
        await AppDialogs.error(
          context,
          e.toString().replaceAll(RegExp("\\[.*?\\]"), ""),
        );
      }
    }

    return isSignedIn;
  }

  //Database
  Future addExpense(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: .center,
        contentPadding: EdgeInsets.all(32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 1, color: Colors.black),
        ),
        title: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              TextForm(
                text: "Name",
                containerWidth: 130,
                hintText: "Name",
                controller: controllerName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              SizedBox(width: 10),
              TextForm(
                text: "Amount",
                containerWidth: 100,
                hintText: "Amount",
                digitsOnly: true,
                controller: controllerAmount,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  await users
                      .doc(_auth.currentUser!.uid)
                      .collection("expenses")
                      .add({
                        "name": controllerName.text,
                        "amount": controllerAmount.text,
                      });

                  _logger.d("Added expense successfully");

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } catch (error) {
                  _logger.d("Add expense error: $error");
                  if (context.mounted) {
                    await AppDialogs.error(context, error.toString());
                  }
                }
              }
            },
            splashColor: Colors.grey,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: OpenSans(text: "Save", size: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future addIncome(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: .center,
        contentPadding: EdgeInsets.all(32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 1, color: Colors.black),
        ),
        title: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              TextForm(
                text: "Name",
                containerWidth: 130,
                hintText: "Name",
                controller: controllerName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              SizedBox(width: 10),
              TextForm(
                text: "Amount",
                digitsOnly: true,
                containerWidth: 100,
                hintText: "Amount",
                controller: controllerAmount,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  await users
                      .doc(_auth.currentUser!.uid)
                      .collection("incomes")
                      .add({
                        "name": controllerName.text,
                        "amount": controllerAmount.text,
                      });

                  _logger.d("Added income successfully");

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } catch (error) {
                  _logger.d("Add expense error: $error");
                  if (context.mounted) {
                    await AppDialogs.error(context, error.toString());
                  }
                }
              }
            },
            splashColor: Colors.grey,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: OpenSans(text: "Save", size: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future expensesStream() async {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> snapshot
          in users
              .doc(_auth.currentUser!.uid)
              .collection("expenses")
              .snapshots()) {
        expenses = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          expenses.add(BudgetEntry.fromJson(doc.data()));
        }
        
        calculate();
      }
    } catch (e) {
      _logger.d("Expenses stream error: $e");
    }
  }

  void incomesStream() async {
    try {
      await for (QuerySnapshot<Map<String, dynamic>> snapshot
          in users
              .doc(_auth.currentUser!.uid)
              .collection("incomes")
              .snapshots()) {
        incomes = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          incomes.add(BudgetEntry.fromJson(doc.data()));
        }

        calculate();
      }
    } catch (e) {
      _logger.d("Incomes stream error: $e");
    }
  }

  void calculate() {
    totalExpense = 0;
    totalIncome = 0;  
    
    for (BudgetEntry expense in expenses) {
      totalExpense += int.parse(expense.amount);
    }

    for (BudgetEntry income in incomes) {
      totalIncome += int.parse(income.amount);
    }

    budgetLeft = totalIncome - totalExpense;
    notifyListeners();
  }

  Future<void> reset() async {
    QuerySnapshot<Map<String, dynamic>> expanses = await users
        .doc(_auth.currentUser!.uid)
        .collection("expenses")
        .get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in expanses.docs) {
      await doc.reference.delete();
    }

    QuerySnapshot<Map<String, dynamic>> incomes = await users
        .doc(_auth.currentUser!.uid)
        .collection("incomes")
        .get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in incomes.docs) {
      await doc.reference.delete();
    }

    notifyListeners();
  }
}
