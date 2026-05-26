import 'package:budget/desktop/expensive_view_desktop.dart';
import 'package:budget/desktop/login_view_desktop.dart';
import 'package:budget/mobile/expensive_view_mobile.dart';
import 'package:budget/mobile/login_view_mobile.dart';
import 'package:budget/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResponsiveHandler extends HookConsumerWidget {
  const ResponsiveHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ViewModel viewModelProvider = ref.watch(viewModel);

    if (viewModelProvider.isSignedIn == true) {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return ExpensiveViewDesktop();
          } else {
            return ExpensiveViewMobile();
          }
        },
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return LoginViewDesktop();
          } else {
            return LoginViewMobile();
          }
        },
      );
    }
  }
}
