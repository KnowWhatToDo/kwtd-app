import 'package:country_picker/country_picker.dart'
    show Country, showCountryPicker;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/screens/otp_screen.dart';
import 'package:kwtd/styles/styles.dart';
import 'package:kwtd/controllers/user_details.dart';
import 'package:kwtd/services/alert_dialog.dart';

class SignIn extends ConsumerStatefulWidget {
  final String loginType;
  const SignIn({super.key, required this.loginType});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 11,
    geographic: false,
    level: 1,
    name: "India",
    example: "example",
    displayName: "India",
    displayNameNoCountryCode: "displayNameNoCountryCode",
    e164Key: "e164Key",
  );

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.25,
                ),
                const Text(
                  'Please enter your number:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                const Text(
                  'You will be sent a one time password to sign in.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.08,
                        width: screenWidth * 0.23,
                        child: ElevatedButton(
                          onPressed: () {
                            showCountryPicker(
                              context: context,
                              favorite: <String>['IN'],
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                setState(() {
                                  selectedCountry = country;
                                });
                              },
                            );
                          },
                          child: Text('+${selectedCountry.phoneCode}'),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.66,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autocorrect: true,
                          enableSuggestions: true,
                          controller: phoneNumberController,
                          decoration: inputStyle(context).copyWith(
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Checking for a valid phone number
                    if (phoneNumberController.text.isEmpty) {
                      showPopUp(
                        context: context,
                        message: 'Please enter your phone number',
                      );
                      return;
                    } else if (phoneNumberController.text.contains(' ')) {
                      showPopUp(
                        context: context,
                        message:
                            'Please enter your phone number without spaces',
                      );
                      return;
                    } else if (phoneNumberController.text.length < 10 ||
                        phoneNumberController.text.length > 15) {
                      showPopUp(
                        context: context,
                        message: 'Please enter your complete number',
                      );
                      return;
                    }
                    // phone number provider is given the value
                    ref.read(phoneNumberStateProvider.notifier).state =
                        '+${selectedCountry.phoneCode.trim()}${phoneNumberController.text.toString().trim()}';
                    if (kDebugMode) {
                      print(ref.read(phoneNumberStateProvider));
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => OtpScreen(
                              loginType: widget.loginType,
                            )),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.3,
                      screenHeight * 0.02,
                      screenWidth * 0.3,
                      screenHeight * 0.02,
                    ),
                    child: const Text(
                      'Send OTP',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
