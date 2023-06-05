import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/screens/signin.dart';
import 'package:kwtd/widgets/icon_button.dart';

class DefaultPage extends ConsumerStatefulWidget {
  const DefaultPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DefaultPageState();
}

class _DefaultPageState extends ConsumerState<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('assets/logo.jpg'),
              height: screenHeight * 0.33,
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            const Text(
              'Helping you navigate the tech industry',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child: IconTextButton(
                icon: const Icon(
                  Icons.book,
                  color: Colors.white,
                ),
                text: "Sign In as a Mentee",
                backgroundColor: Colors.deepOrange,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignIn(loginType: 'mentee'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child: IconTextButton(
                icon: const Icon(
                  Icons.assignment_ind_sharp,
                  color: Colors.white,
                ),
                text: "Sign In as a Mentor",
                backgroundColor: Colors.deepPurpleAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignIn(loginType: 'mentor'),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
