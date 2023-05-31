import 'package:flutter/material.dart';
import 'package:kwtd/screens/blogs.dart';
import 'package:kwtd/screens/mentee_screens/mentee_home.dart';
import 'package:kwtd/screens/mentee_screens/mentee_profile.dart';
import 'package:kwtd/screens/mentor_screens/mentor_home.dart';
import 'package:kwtd/screens/mentor_screens/mentor_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  final bool isMentor = true;

  final List<Widget> menteeScreens = const [
    BlogScreen(),
    MenteeHome(),
    MenteeProfile(),
  ];

  final List<Widget> mentorScreens = const [
    BlogScreen(),
    MentorHome(),
    MentorProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Know What To Do"),
        centerTitle: true,
      ),
      body: isMentor
          ? mentorScreens[_currentIndex]
          : menteeScreens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (tap) {
          setState(() {
            _currentIndex = tap;
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
