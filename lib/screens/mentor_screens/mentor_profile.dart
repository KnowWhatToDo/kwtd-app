import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/widgets/list_button.dart';

class MentorProfile extends ConsumerStatefulWidget {
  const MentorProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MentorProfileState();
}

class _MentorProfileState extends ConsumerState<MentorProfile> {
  String? name = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
              // Handle Mentor profile Edit
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
            label: 'Mentees',
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
    );
  }
}
