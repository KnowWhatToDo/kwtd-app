import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

InputDecoration inputStyle(BuildContext context) {
  return InputDecoration(
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}

TextStyle h1() {
  return const TextStyle(fontWeight: FontWeight.bold, fontSize: 36);
}

PinTheme defaultPinTheme(BuildContext context) {
  return PinTheme(
    width: 45,
    height: 50,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
