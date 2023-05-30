import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/screens/views/meetings_view.dart';

class MenteeHome extends ConsumerStatefulWidget {
  const MenteeHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenteeHomeState();
}

class _MenteeHomeState extends ConsumerState<MenteeHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: screenHeight * 0.28,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
            ),
            items: [1, 2, 3, 4, 5].map((i) {
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
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'text $i',
                        style: const TextStyle(fontSize: 36.0),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const MeetingsView(),
        ],
      ),
    );
  }
}
