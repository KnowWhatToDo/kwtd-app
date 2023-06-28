import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/controllers/mentee_controller.dart';
import 'package:kwtd/controllers/user_details.dart';
import 'package:kwtd/models/mentee.dart';
import 'package:kwtd/screens/mentee_screens/domain_selection.dart';
import 'package:localstorage/localstorage.dart';

class MenteeProfielEdit extends ConsumerStatefulWidget {
  const MenteeProfielEdit({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MenteeProfielEditState();
}

class _MenteeProfielEditState extends ConsumerState<MenteeProfielEdit> {
  String? name = FirebaseAuth.instance.currentUser!.displayName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _years = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
    'Working',
  ];

  final List<String> _branches = [
    'Computer Science',
    'Mechanical',
    'Electrical',
    'Civil',
    'Other'
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();

  late Future<Mentee> mentee;
  final LocalStorage storage = LocalStorage("kwtd");
  Future<Mentee> getData() async {
    String phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber!;
    if (kDebugMode) {
      print(phoneNumber);
    }
    late Mentee mentee;
    try {
      mentee = menteeFromJson(storage.getItem('menteeUserDetails'));
      // ignore: unnecessary_null_comparison
      if (mentee == null) {
        await getMentee(phoneNumber.substring(phoneNumber.length - 10));
      }

      setState(() {
        _nameController.text = mentee.name;
        _emailController.text = mentee.email;
        _yearController.text = mentee.collegeYear;
        _branchController.text = mentee.collegeBranch;
        _collegeController.text = mentee.collegeName;
        _linkedinController.text = mentee.linkedInProfile;
        if (kDebugMode) {
          print('mentee initialized');
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print('API error');
      }
    }
    return mentee;
  }

  @override
  void initState() {
    _nameController.text = FirebaseAuth.instance.currentUser!.displayName!;
    _emailController.text = '';
    _collegeController.text = '';
    _linkedinController.text = '';
    mentee = getData();
    if (!_branches.contains(_branchController.text)) {
      setState(() {
        _branchController.text = _branches[0];
      });
    }
    if (!_years.contains(_yearController.text)) {
      setState(() {
        _yearController.text = _years[0];
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _branchController.dispose();
    _collegeController.dispose();
    _emailController.dispose();
    _linkedinController.dispose();
    _nameController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: FutureBuilder(
        future: mentee,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Initicon(
                        text: name!,
                        elevation: 4,
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      name!,
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.blueGrey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _nameController.text = value!;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _emailController.text = value!;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _yearController.text.isEmpty
                          ? _years[0]
                          : _yearController.text,
                      items: _years.map((String year) {
                        return DropdownMenuItem<String>(
                          value: year,
                          child: Text(year),
                        );
                      }).toList(),
                      decoration:
                          const InputDecoration(labelText: 'Year of Education'),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your year of education';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _yearController.text = value!;
                        });
                      },
                      onSaved: (value) {
                        _yearController.text = value!;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _branchController.text.isEmpty
                          ? _branches[0]
                          : _branchController.text,
                      items: _branches.map((String branch) {
                        return DropdownMenuItem<String>(
                          value: branch,
                          child: Text(branch),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                          labelText: 'Branch of Engineering'),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your branch of engineering';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _branchController.text = value!;
                        });
                      },
                      onSaved: (value) {
                        _branchController.text = value!;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _collegeController,
                      decoration:
                          const InputDecoration(labelText: 'Name of College'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the name of your college';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _collegeController.text = value!;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _linkedinController,
                      decoration: const InputDecoration(
                          labelText: 'LinkedIn Profile URL'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your LinkedIn profile URL';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _linkedinController.text = value;
                        if (kDebugMode) {
                          print(_linkedinController.text);
                        }
                      },
                      onSaved: (value) {
                        _linkedinController.text = value!;
                        if (kDebugMode) {
                          print(_linkedinController.text);
                        }
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm(mentee: snapshot.data);
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _submitForm({required Mentee? mentee}) {
    var navigator = Navigator.of(context);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      mentee!.name = _nameController.text;
      mentee.email = _emailController.text;
      mentee.collegeYear = _yearController.text;
      mentee.collegeBranch = _branchController.text;
      mentee.collegeName = _collegeController.text;
      mentee.linkedInProfile = _linkedinController.text;

      ref.watch(menteeUserProvider.notifier).state = mentee;

      if (kDebugMode) {
        print('Name: ${_nameController.text}');
        print('Email: ${_emailController.text}');
        print('Year: ${_yearController.text}');
        print('Branch: ${_branchController.text}');
        print('College: ${_collegeController.text}');
        print('LinkedIn: ${_linkedinController.text}');
      }

      navigator.push(
        MaterialPageRoute(
          builder: (context) => const DomainSelectionScreen(),
        ),
      );
    }
  }
}
