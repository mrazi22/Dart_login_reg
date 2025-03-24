import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lastauth/screens/home.dart';
import 'package:lastauth/screens/welcome.dart';
import 'package:lastauth/theme/theme.dart';

import 'models/users.dart'; // Import GetX



// Global variable to store the user model
UserModel? globalUserModel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive Flutter
  await Hive.initFlutter();

  // Register UserModel adapter with Hive
  Hive.registerAdapter(UserModelAdapter()); // Replace UserModelAdapter with your actual adapter

  // Open the user box
  final userBox = await Hive.openBox<UserModel>('userBox');

  // Get user data from the box and store it in the global variable
  globalUserModel = userBox.get('currentUser');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (globalUserModel == null) {
      print("[❌HIVE]No active user session found. Navigating to WelcomeScreen.");
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightMode,
        home: const WelcomeScreen(),
      );
    } else {
      print("[✅HIVE]Active user session found for user: ${globalUserModel?.username ?? 'Unknown'}. Navigating to HomeScreen.");
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightMode,
        home: const HomeScreen(), // Replace HomeScreen
      );
    }
  }
}
