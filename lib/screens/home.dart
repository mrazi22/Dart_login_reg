
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../resources/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  // Function to format the date (move it to the class level)
  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _showAddProjectDialog(BuildContext context) {
    final dilogbg = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[900]
        : Colors.white;
    TextEditingController projectTitleController = TextEditingController();
    File? imageFile;

    Future<void> _selectDate(BuildContext context, StateSetter setState) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    Future<void> _pickImage(ImageSource source) async {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        alignment: Alignment.center,
        backgroundColor: dilogbg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: 450,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'A D D  N E W  P R O J E C T',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Enter details based on your project to create a new one.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: projectTitleController,
                          decoration: const InputDecoration(labelText: 'Project Title'),
                        ),
                        ListTile(
                          title: Text('Created On: ${_formatDate(selectedDate)}'),
                          trailing: const Icon(Icons.calendar_today),
                          onTap: () => _selectDate(context, setState),
                        ),
                        TextField(
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'Created By: ${'username'}',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => _pickImage(ImageSource.camera),
                              child: const Text('Take Photo'),
                            ),
                            ElevatedButton(
                              onPressed: () => _pickImage(ImageSource.gallery),
                              child: const Text('Upload Image'),
                            ),
                          ],
                        ),
                        if (imageFile != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.file(imageFile!),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: const Text('Create'),
                          onPressed: () {
                            String projectTitle = projectTitleController.text;
                            if (projectTitle.isNotEmpty) {
                              _createProject(projectTitle, selectedDate, imageFile);
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please enter a project title')));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _createProject(String projectTitle, DateTime createdOn, File? imageFile) async {
    String userId = 'unique_user_id_123';
    Map<String, String> requestBody = {
      'projectName': projectTitle,
      'createdOn': _formatDate(createdOn),
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