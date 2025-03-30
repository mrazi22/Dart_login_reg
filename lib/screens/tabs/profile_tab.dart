import 'package:flutter/material.dart';

import '../../models/project/ProjectModel.dart';

class ProfileTab extends StatefulWidget {
  final ProjectModel project;
  const ProfileTab({super.key, required this.project});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile Tab"));
  }
}
