import 'package:budget/components/open_sans.dart';
import 'package:budget/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerExpense extends HookConsumerWidget {
  const DrawerExpense({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ViewModel viewModelProvider = ref.watch(viewModel);
    
    return Drawer(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          DrawerHeader(
            padding: EdgeInsets.only(bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                shape: .circle,
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: CircleAvatar(
                radius: 180,
                backgroundColor: Colors.white,
                child: Image(
                  height: 100,
                  image: AssetImage("assets/logo.png"),
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          MaterialButton(
            onPressed: () async {
              await viewModelProvider.logout();
            },
            color: Colors.black,
            height: 50,
            minWidth: 200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 20,
            child: OpenSans(text: "Logout", size: 20, color: Colors.white),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              IconButton(
                onPressed: () async {
                  await launchUrl(
                    Uri.parse("https://www.instagram.com/bohdanbats/"),
                  );
                },
                icon: SvgPicture.asset("assets/instagram.svg", width: 35),
              ),
              IconButton(
                onPressed: () async {
                  await launchUrl(Uri.parse("https://t.me/bats_bohdan/"));
                },
                icon: SvgPicture.asset("assets/telegram.svg", width: 35),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
