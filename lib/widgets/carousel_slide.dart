import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  final void onTap;
  final Widget widget;
  const CarouselWidget({super.key, required this.onTap, required this.widget});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap;
      },
      child: Container(
        width: MediaQuery.of(context).size.height * (16.0 / 9.2),
        child: widget,
      ),
    );
  }
}
