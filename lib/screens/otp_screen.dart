import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/controllers/user_details.dart';
import 'package:kwtd/services/authentication.dart';
import 'package:kwtd/styles/styles.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key, required this.loginType});

  final String loginType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final otpController = TextEditingController();
  String verificationId = '';
  int? resendtoken;

  void sendOTP({required String phoneNumber}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          this.verificationId = verificationId;
          resendtoken = resendToken;
        });
      },
      timeout: const Duration(minutes: 2),
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  @override
  void initState() {
    sendOTP(phoneNumber: ref.read(phoneNumberStateProvider));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter OTP'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.06,
              ),
              Text(
                'Verification',
                textAlign: TextAlign.center,
                style: h1(),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              const Text(
                'Enter the code sent at:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                ref.read(phoneNumberStateProvider),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              RichText(
                text: TextSpan(
                  text: 'Edit',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                    },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.06,
              ),
              Pinput(
                controller: otpController,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsRetrieverApi,
                length: 6,
                defaultPinTheme: defaultPinTheme(context),
                focusedPinTheme: defaultPinTheme(context).copyDecorationWith(
                  border: Border.all(
                    color: const Color.fromRGBO(114, 178, 238, 1),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                submittedPinTheme: defaultPinTheme(context).copyDecorationWith(
                  color: const Color.fromRGBO(234, 239, 243, 1),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              ElevatedButton(
                onPressed: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text,
                  );

                  bool authStatus = await phoneNumberSignIn(
                    context: context,
                    credential: credential,
                  );

                  if (authStatus) {
                    if (kDebugMode) {
                      print('unable to reach the homepage....');
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.popUntil(context, (route) => route.isFirst);
                  } else {
                    return;
                  }
                },
                child: const Text('SUBMIT'),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              const Text(
                'Didn\'t receive the text yet?',
                style: TextStyle(fontSize: 16),
              ),
              RichText(
                text: TextSpan(
                  text: 'Resend',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      try {
                        sendOTP(
                          phoneNumber: ref.read(phoneNumberStateProvider),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Resent code'),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.code),
                          ),
                        );
                      }
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
