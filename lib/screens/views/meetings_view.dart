// import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:kwtd/controllers/mentee_controller.dart';
import 'package:kwtd/controllers/mentor_controller.dart';
import 'package:kwtd/models/mentee.dart';
import 'package:kwtd/models/mentor.dart';

class MeetingsView extends ConsumerStatefulWidget {
  const MeetingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeetingsViewState();
}

class _MeetingsViewState extends ConsumerState<MeetingsView> {
  @override
  void initState() {
    getMentee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [],
    );
  }

  void getMentee() async {
    // Mentee mentee = await getMenteeDetails();
    // if (kDebugMode) {
    //   print('Mentee name: $mentee.name');
    // }
    // Mentor mentor = await getMentorDetails();
    // print(mentor.collegeName);
  }
}
