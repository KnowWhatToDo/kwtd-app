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

  String meetingState = 'not-registered';

  @override
  Widget build(BuildContext context) {
    return (meetingState == 'not-registered')
        ? const NotRegistered()
        : Container();
  }

  void getMentee() async {
    // Mentee mentee = await getMenteeDetails();
    // if (kDebugMode) {
    //   print('Mentee name: $mentee.name');
    // }
    // Mentor mentor = await getMentorDetails();
    // print(mentor.experiences[0].endDate.toString().split(' ')[0]);
  }
}

class NotRegistered extends StatelessWidget {
  const NotRegistered({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 0.96,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Just one last step :-)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Goes to registeration page....')));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange.shade700),
              child: const Text('Complete Registeration'),
            )
          ],
        ),
      ),
    );
  }
}
