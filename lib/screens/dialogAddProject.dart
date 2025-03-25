import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../models/ProjectModel.dart';
import '../widgets/colors.dart';
import '../widgets/textFieldInput.dart';

class DialogAddProject extends StatefulWidget {
  final ProjectModel? project;
  final Function addProject;

  const DialogAddProject({super.key, required this.addProject, this.project});

  @override
  State<DialogAddProject> createState() => _DialogAddProjectState();
}

class _DialogAddProjectState extends State<DialogAddProject> {
  final TextEditingController _projectTitle = TextEditingController();
  DateTime _dateTime = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _imageFile;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final color1 = Theme.of(context).brightness == Brightness.dark
        ? Colors.white12
        : Colors.black12;
    final reverse = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldInput(
                textEditingController: _projectTitle,
                textInputType: TextInputType.text,
                labelText: 'Project Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Project Title';
                  }
                  return null;
                },
                enabled: true,
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: TextEditingController(
                    text: globalUserModel?.username ?? 'Unknown'),
                textInputType: TextInputType.text,
                labelText: 'Created By',
                enabled: false,
                labelStyle: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Creation Date:",
                          style: TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: _showDatePicker,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: color1),
                              borderRadius: BorderRadius.circular(5),
                              color: color1,
                            ),
                            child: Text(
                              DateFormat.yMMMd().format(_dateTime),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: InkWell(
                  onTap: _pickImage,
                  child: DottedBorder(
                    borderType: BorderType.RRect, // Corrected import and usage
                    color:  Colors.grey,
                    radius: const Radius.circular(12),
                    dashPattern: const [5, 5],
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        child: _imageFile != null
                            ? Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        )
                            : Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.image,
                                  color: Colors.grey, size: 50),
                              Text(
                                "Click here to upload image",
                                style: TextStyle(color: secondaryColor),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.addProject(
                          _projectTitle.text,
                          _dateTime,
                          _imageFile,
                        );
                        Navigator.of(context).pop();
                      }


                      // Implement your create logic here
                      // You can access _projectTitle.text, _dateTime, and _imageFile
                      // to create your project.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(160, 48), // Increase width and height
                    ),
                    child: const Text(
                      'Create',
                      style: TextStyle(color: Colors.white), // White text
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(160, 48), // Increase width and height
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white), // White text
                    ),
                  ),
                ],
              ),
              // Add other fields as needed here
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
        });
      }
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }


}