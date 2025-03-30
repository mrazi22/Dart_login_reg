import 'package:flutter/material.dart';

import '../../models/project/ProjectModel.dart';

class ImagesTab extends StatefulWidget {
  final ProjectModel project;
  const ImagesTab({super.key, required this.project});

  @override
  State<ImagesTab> createState() => _ImagesTabState();
}

class _ImagesTabState extends State<ImagesTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Images Tab"),);
  }
}
