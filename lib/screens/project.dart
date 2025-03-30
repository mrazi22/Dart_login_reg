import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastauth/models/project/ProjectModel.dart';
import 'package:lastauth/screens/tabs/category_tab.dart';
import 'package:lastauth/screens/tabs/images_tab.dart';
import 'package:lastauth/screens/tabs/members_tab.dart';
import 'package:lastauth/screens/tabs/profile_tab.dart';
import 'package:lastauth/screens/tabs/updates_tab.dart';


class ProjectScreen extends StatefulWidget {
  final ProjectModel project;
  const ProjectScreen({super.key, required this.project});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  late PageController pageController;
  int _selectedIndex = 0;

  void onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.project.projecttitle!,
          maxLines: 2,
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          CategoryTab(project: widget.project),
          MembersTab(project: widget.project),
          UpdatesTab(project: widget.project),
          ImagesTab(project: widget.project),
          ProfileTab(project: widget.project),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
          onTap: navigationTapped,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.location_solid, color: _selectedIndex == 0 ? Colors.blue : Colors.grey,),
              label: "Category",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_2_fill, color: _selectedIndex == 1 ? Colors.blue : Colors.grey,),
              label: "Members",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bookmark_fill, color: _selectedIndex == 2 ? Colors.blue : Colors.grey,),
              label: "Update",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image,color:  _selectedIndex == 3 ? Colors.blue : Colors.grey,),
              label: "Images",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bell, color: _selectedIndex == 4 ? Colors.blue : Colors.grey,),
              label: "Profile",
            ),
          ]
      ),
    );
  }
}
