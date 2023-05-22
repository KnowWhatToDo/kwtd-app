import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenteeHome extends ConsumerStatefulWidget {
  const MenteeHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenteeHomeState();
}

class _MenteeHomeState extends ConsumerState<MenteeHome> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    String? name = FirebaseAuth.instance.currentUser!.displayName;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(
            'Welcome $name',
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
