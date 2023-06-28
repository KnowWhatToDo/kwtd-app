import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kwtd/screens/blogs.dart';
import 'package:kwtd/screens/mentee_screens/mentee_home.dart';
import 'package:kwtd/screens/mentee_screens/mentee_profile.dart';
import 'package:kwtd/screens/mentor_screens/mentor_home.dart';
import 'package:kwtd/screens/mentor_screens/mentor_profile.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  bool _isMentor = false;
  late final Future<bool> _isMentorFuture;

  Future<bool> getType() async {
    await dotenv.load(fileName: 'assets/.env');
    String? userType;
    userType = LocalStorage('user_data.json').getItem('type');
    if (userType == null) {
      String phone = FirebaseAuth.instance.currentUser!.phoneNumber!;
      phone = phone.substring(phone.length - 10);
      var res = await http
          .get(Uri.parse('${dotenv.get('TEST_ADDRESS')}/search?phone=$phone'));
      userType = res.body;
    }
    if (userType == 'mentee') {
      setState(() {
        _isMentor = false;
      });
    } else if (userType == 'mentor') {
      setState(() {
        _isMentor = true;
      });
    }
    return _isMentor;
  }

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
  void initState() {
    _isMentorFuture = getType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Know What To Do"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _isMentorFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _isMentor
                ? mentorScreens[_currentIndex]
                : menteeScreens[_currentIndex];
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
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
