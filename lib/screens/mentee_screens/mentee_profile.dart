import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class MenteeProfile extends StatefulWidget {
  const MenteeProfile({super.key});

  @override
  State<MenteeProfile> createState() => _MenteeProfileState();
}

class _MenteeProfileState extends State<MenteeProfile> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    String? name = FirebaseAuth.instance.currentUser!.displayName;

    return SizedBox(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Initicon(
              text: name!,
              elevation: 4,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 28,
              color: Colors.blueGrey.shade800,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
