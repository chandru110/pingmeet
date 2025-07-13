import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pingmeet/firebase_options.dart';
// import 'package:pingmeet/pages/home.dart';
import 'package:pingmeet/pages/onboarding.dart';
//this below command is used getting fingerprint id for firebase
//keytool -list -v -alias androiddebugkey -keystore "%USERPROFILE%\.android\debug.keystore" -storepass android -keypass android

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Onboarding(), debugShowCheckedModeBanner: false);
  }
}
