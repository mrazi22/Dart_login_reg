import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastauth/models/project/ProjectModel.dart'; // If you're using GetX

class CategoryTab extends StatefulWidget {
  final ProjectModel project;
  CategoryTab({required this.project});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Categories related to project ID: ${widget.project.projectid}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate back to the HomeScreen (or wherever you want to go).
              Get.offAllNamed('/'); // If using GetX named routes, or Get.offAll(() => HomeScreen());
            },
            child: Text('Go Back Home'),
          ),
          // Add your category related widgets here
          // Example:
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(title: Text('Category 1')),
              ListTile(title: Text('Category 2')),
              ListTile(title: Text('Category 3')),
            ],
          ),
        ],
      ),
    );
  }
}