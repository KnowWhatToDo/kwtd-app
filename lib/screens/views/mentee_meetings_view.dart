import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:kwtd/models/mentee.dart';
import 'package:kwtd/screens/mentee_screens/mentee_edit_profile.dart';

class MenteeMeetingsView extends ConsumerStatefulWidget {
  const MenteeMeetingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeetingsViewState();
}

class _MeetingsViewState extends ConsumerState<MenteeMeetingsView> {
  @override
  void initState() {
    getMenteeDetails();
    super.initState();
  }

  String meetingState = 'not-registered';

  @override
  Widget build(BuildContext context) {
    return (meetingState == 'not-registered')
        ? const NotRegistered()
        : Container();
  }

  void getMenteeDetails() async {
    // await dotenv.load(fileName: 'assets/.env');
    // var res = await http.get(
    //   Uri.parse('${dotenv.get('TEST_ADDRESS')}/getMentee?phone=1122334455'),
    // );
    // print(res.body);
    // Mentee mentee = menteeFromJson(res.body);
    // // print(mentee.name);
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
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MenteeProfielEdit(),
                  ),
                );
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
