
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../resources/services.dart';
import '../widgets/colors.dart';
import 'dialogAddProject.dart';
import 'dialogTitle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //show dialogue
  void _showAddProjectDialog(BuildContext context) {
    final dialog = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[900]
        : Colors.white;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        alignment:Alignment.center,
            backgroundColor: dialog,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width:450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogTitle(title: 'A D D  N E W  P R O J E C T'),
              Text('Enter details based on your project inorder to promote better user experience',
                textAlign: TextAlign.center,
                style: TextStyle(color: secondaryColor, fontSize: 12),
              ),
              DialogAddProject(addProject: _createProject,),

            ]
          )

        )
      )

    );

  }






  void _createProject(String projectTitle, DateTime createdOn, File? imageFile) async {
    String userId = 'unique_user_id_123';
    Map<String, String> requestBody = {
      'projectName': projectTitle,
      'createdOn': DateFormat('yyyy-MM-dd').format(createdOn),
      'userId': userId,
    };
    List<http.MultipartFile> multipartFiles = [];
    if (imageFile != null) {
      multipartFiles.add(await http.MultipartFile.fromPath('image', imageFile.path));
    }
    final response = await Services.createProject(requestBody, multipartFiles);

    if (response['status'] == 'success') {
      Get.snackbar('Success', response['message']);
    } else {
      Get.snackbar('Error', response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (context, index) {
                return const ListTile(
                  title: Text('Project Name'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  _showAddProjectDialog(context);
                },
                child: const Text(
                  'Add Project +',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}