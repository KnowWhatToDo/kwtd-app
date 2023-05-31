import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentorHome extends ConsumerStatefulWidget {
  const MentorHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MentorHomepageState();
}

class _MentorHomepageState extends ConsumerState<MentorHome> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'TODO: Mentor Home Page',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    );
  }
}
