
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lastauth/main.dart';
import 'package:lastauth/screens/project.dart';
import '../models/project/ProjectModel.dart';
import '../resources/services.dart';
import '../widgets/colors.dart';
import 'tabs/category_tab.dart';
import 'dialogAddProject.dart';
import 'dialogTitle.dart';
//hive imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProjectModel> projects = [];
  late Box<ProjectModel> _projectBox ;

  // Show dialogue
  void _showAddProjectDialog(BuildContext context) {
    final dialog = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[900]
        : Colors.white;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        alignment: Alignment.center,
        backgroundColor: dialog,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DialogTitle(title: 'A D D  N E W  P R O J E C T'),
              Text(
                'Enter details based on your project inorder to promote better user experience',
                textAlign: TextAlign.center,
                style: TextStyle(color: secondaryColor, fontSize: 12),
              ),
              DialogAddProject(addProject: _createProject),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchProjects();
    _openHiveBox();
  }
  Future<void> _openHiveBox() async {
    _projectBox = await Hive.openBox<ProjectModel>('projectsBox');
  }

  Future<void> _fetchProjects() async {
    try {
      final response = await Services.getProjects();
      print("Response: ${response}");
      if (response['status'] == 'success') {
        setState(() {
          projects = (response['data'] as List)
              .map((json) => ProjectModel.fromJson(json))
              .toList();
          //save to hive
          _saveProjectsToHive(projects);
        });
      } else {
        Get.snackbar('Error', response['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load projects: $e');
    }
  }
  Future<void> _saveProjectsToHive(List<ProjectModel> projects) async {
    await _projectBox.clear(); // Clear existing data
    await _projectBox.addAll(projects); // Add all projects
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
              itemCount: currentProjects.length,
              itemBuilder: (context, index) {
                final project = currentProjects[index];
                return GestureDetector( // Added GestureDetector for onTap
                  onTap: () {
                    Get.to(() => ProjectScreen(project: project), transition: Transition.rightToLeft);
                  },
                  child: Container( // Added Container for shadow and styling
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(project.projecttitle!),
                      subtitle: Text(DateFormat.yMMMd().format(DateTime.parse(project.date!))),
                      leading: project.image!.isEmpty
                          ? Container( // Changed to Container for square shape
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            project.projecttitle![0].toUpperCase(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                          : Container( // Changed to Container for square shape
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),


                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: Services.uploads + project.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),

                      ),
                      trailing: IconButton( // Add delete icon
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Project?'),
                              content: const Text('Are you sure you want to delete this project?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    final response = await Services.deleteProject(project.projectid!);
                                    if (response['status'] == 'success') {
                                      setState(() {
                                        projects.removeAt(index);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Project deleted successfully')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Failed to delete project: ${response['message']}')),
                                      );
                                    }
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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
                onPressed: () => _showAddProjectDialog(context),
                child: const Text('Add Project +', style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createProject(ProjectModel project) async {
    try {
      // Prepare the request body from the ProjectModel.
      Map<String, String> requestBody = {
        'projectid': project.projectid!,
        'publisherid': project.publisherid!,
        'accessid': project.accessid!,
        'admin': project.admin!,
        'projecttitle': project.projecttitle!,
        'date': project.date!,
        'image': project.image!,
      };

      // Prepare the multipart file if an image is selected.
      List<http.MultipartFile> multipartFiles = [];
      if (project.image != null && project.image!.isNotEmpty) {
        multipartFiles.add(await http.MultipartFile.fromPath('image', project.image!));
      }

      final response = await Services.createProject(requestBody, multipartFiles);
      print("Response: $response");
      if (response['status'] == 'success') {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Project added successfully."),
            showCloseIcon: true,
          ),
        );
        ProjectModel newPro = ProjectModel.fromJson(response['data']);
        if (project.image != null && project.image!.isNotEmpty) {
          final cachedImagePath = await _getCachedImagePath(Services.uploads + project.image!);
          newPro = newPro.copyWith(image: cachedImagePath); //update the project model with the file path
        }
        projects.add(newPro);
        setState(() {
          _projectBox.add(newPro); // Add new project to Hive
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add project: ${response['message']}"),
            showCloseIcon: true,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
          showCloseIcon: true,
        ),
      );
    }
  }
}

Future<String?> _getCachedImagePath(String imageUrl) async {
  try {
    final fileInfo = await DefaultCacheManager().getFileFromCache(imageUrl);
    return fileInfo?.file.path;
  } catch (e) {
    print('Error getting cached image path: $e');
    return null;
  }
}