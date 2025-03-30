import 'package:flutter/material.dart';

import '../../models/project/ProjectModel.dart';

class MembersTab extends StatefulWidget {
  final ProjectModel project;
  const MembersTab({super.key, required this.project});

  @override
  State<MembersTab> createState() => _MembersTabState();
}

class _MembersTabState extends State<MembersTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Members Tab"));
  }
}
