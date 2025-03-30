import 'package:flutter/material.dart';

import '../../models/project/ProjectModel.dart';

class UpdatesTab extends StatefulWidget {
  final ProjectModel project;
  const UpdatesTab({super.key, required this.project});

  @override
  State<UpdatesTab> createState() => _UpdatesTabState();
}

class _UpdatesTabState extends State<UpdatesTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Updates Tab"));
  }
}
