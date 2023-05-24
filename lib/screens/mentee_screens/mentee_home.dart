import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/controllers/user_details.dart';

class MenteeHome extends ConsumerStatefulWidget {
  const MenteeHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenteeHomeState();
}

class _MenteeHomeState extends ConsumerState<MenteeHome> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    String name = FirebaseAuth.instance.currentUser!.displayName ??
        ref.read(usernameProvider);

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
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: screenHeight * 0.28,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
            ),
            items: [
              dummyWidget(context),
              dummyWidget(context),
              dummyWidget(context)
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue.shade800,
                        width: 3,
                      ),
                    ),
                    child: i,
                  );
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

Widget dummyWidget(BuildContext context) {
  return GestureDetector(
    onTap: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'LoL',
            textAlign: TextAlign.center,
          ),
        ),
      );
    },
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.28,
      width: MediaQuery.of(context).size.height * (16.0 / 9.0),
      child: const Text(
        "Connect with us on WhatsApp.",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
