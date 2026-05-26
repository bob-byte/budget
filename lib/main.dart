import 'package:budget/firebase_options.dart';
import 'package:budget/responsive_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  if (kIsWeb) {
    setPathUrlStrategy();
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Web uses Firebase signInWithPopup; initializing Google Sign-In here
  // duplicates GSI setup and triggers "initialize() called multiple times".
  if (!kIsWeb) {
    await GoogleSignIn.instance.initialize();
  }

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveHandler(),
      title: "Budget",
      debugShowCheckedModeBanner: false,
    );
  }
}
