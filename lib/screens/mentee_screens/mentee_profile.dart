import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:kwtd/screens/mentee_screens/mentee_edit_profile.dart';
import 'package:kwtd/widgets/list_button.dart';

class MenteeProfile extends StatefulWidget {
  const MenteeProfile({super.key});

  @override
  State<MenteeProfile> createState() => _MenteeProfileState();
}

class _MenteeProfileState extends State<MenteeProfile> {
  String? name = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: SizedBox(
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
                backgroundColor: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Text(
              name!,
              style: TextStyle(
                fontSize: 28,
                color: Colors.blueGrey.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListButton(
              label: 'Edit Profile',
              icon: const Icon(
                Icons.edit,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenteeProfielEdit(),
                  ),
                );
              },
            ),
            ListButton(
              label: 'Wallet',
              icon: const Icon(
                Icons.account_balance_wallet,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                // Handle button tap for Wallet
              },
            ),
            ListButton(
              label: 'Mentors',
              icon: const Icon(
                Icons.people,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                // Handle button tap for Mentors
              },
            ),
            ListButton(
              label: 'Settings',
              icon: const Icon(
                Icons.settings,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                // Handle button tap for App Settings
              },
            ),
            ListButton(
              label: 'Log Out',
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
