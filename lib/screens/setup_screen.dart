import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwtd/controllers/mentee_controller.dart';
import 'package:kwtd/controllers/user_details.dart';
import 'package:kwtd/models/mentee.dart';
import 'package:kwtd/screens/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';

class AccountSetup extends ConsumerStatefulWidget {
  const AccountSetup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountSetupState();
}

class _AccountSetupState extends ConsumerState<AccountSetup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getting Started'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please enter your name:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.07,
                0,
                screenWidth * 0.07,
                0,
              ),
              child: TextFormField(
                controller: _controller,
                style: TextStyle(
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value!.trim().isEmpty ||
                      value.contains(RegExp(r'[0-9]'))) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  FirebaseAuth.instance.currentUser!
                      .updateDisplayName(_controller.text);
                  ref.read(usernameProvider.notifier).state = _controller.text;

                  String type =
                      await LocalStorage('user_data.json').getItem('key');
                  if (type == 'mentee') {
                    Mentee mentee = Mentee(
                      name: _controller.text,
                      phone: FirebaseAuth.instance.currentUser!.phoneNumber
                          .toString(),
                      email: '',
                      collegeName: '',
                      collegeYear: '',
                      collegeBranch: '',
                      linkedInProfile: '',
                      questions: [],
                      answers: [],
                      mentors: [],
                    );
                    await createMentee(mentee);
                  } else {}

                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                }
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
