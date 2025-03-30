import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lastauth/screens/home.dart';
import 'package:lastauth/screens/welcome.dart';
import 'package:lastauth/theme/theme.dart';

import 'models/users/users.dart'; // Import GetX
import 'models/project/ProjectModel.dart';



// Global variable to store the user model
UserModel? currentUser;
// Global variable to store the list of projects
List<ProjectModel> currentProjects = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive Flutter
  await Hive.initFlutter();

  // Register UserModel adapter with Hive
  Hive.registerAdapter(UserModelAdapter());

  // Register ProjectModel adapter with Hive
  Hive.registerAdapter(ProjectModelAdapter());

  // Open the user box
  final userBox = await Hive.openBox<UserModel>('userBox');

  // Open the project box
  final projectBox = await Hive.openBox<ProjectModel>('projectsBox'); // Changed to projectsBox

  // Get user data from the box and store it in the global variable
  currentUser = userBox.get('currentUser');

  // Get project data from the box and store it in the global variable
  currentProjects = projectBox.values.toList(); // Retrieve all projects

  if (currentProjects.isNotEmpty) {
    print("[✅HIVE]Active Project sessions found. Restored ${currentProjects.length} projects.");
  } else {
    print("[❌HIVE]No active Project sessions found.");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(currentUser == null
            ? "[❌HIVE]No active user session found. Navigating to WelcomeScreen."
        : "[✅HIVE]Active user session found for user: ${currentUser?.username ?? 'Unknown'}. Navigating to HomeScreen."
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: currentUser == null? WelcomeScreen() : HomeScreen(),
    );
  }
}
