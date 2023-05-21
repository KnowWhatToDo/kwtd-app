import 'package:flutter/material.dart';
import 'package:kwtd/services/alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Used for signing in the OTP obtained
/// requires [context] for showing incorrect otp alert dialsog
Future<bool> phoneNumberSignIn({
  required BuildContext context,
  required PhoneAuthCredential credential,
}) async {
  bool flag = false;
  try {
    await FirebaseAuth.instance.signInWithCredential(credential);
    flag = true;
  } on FirebaseAuthException catch (e) {
    // Showing the incorrect OTP alert dialog
    showPopUp(
      context: context,
      message: e.code,
    );
  }
  return flag;
}
