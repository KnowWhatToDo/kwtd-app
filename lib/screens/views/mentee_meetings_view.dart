import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:kwtd/models/mentee.dart';
import 'package:kwtd/screens/mentee_screens/mentee_edit_profile.dart';
import 'package:localstorage/localstorage.dart';

class MenteeMeetingsView extends ConsumerStatefulWidget {
  const MenteeMeetingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeetingsViewState();
}

class _MeetingsViewState extends ConsumerState<MenteeMeetingsView> {
  late Future<Mentee> mentee;

  @override
  void initState() {
    mentee = getMenteeDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mentee,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isRegistered()
              ? Container()
              : const NotRegistered();
        }
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<Mentee> getMenteeDetails() async {
    await dotenv.load(fileName: 'assets/.env');
    final LocalStorage storage = LocalStorage('kwtd');
    Mentee? mentee;
    mentee = menteeFromJson(storage.getItem('menteeUserDetails'));

    // ignore: unnecessary_null_comparison
    if (mentee == null) {
      String phone = FirebaseAuth.instance.currentUser!.phoneNumber!;
      phone = phone.substring(phone.length - 10);
      var res = await http.get(
        Uri.parse('${dotenv.get('TEST_ADDRESS')}/getMentee?phone=$phone'),
      );
      mentee = menteeFromJson(res.body);
    }
    return mentee;
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
