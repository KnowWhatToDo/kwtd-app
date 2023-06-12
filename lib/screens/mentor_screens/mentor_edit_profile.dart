import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/controllers/mentor_controller.dart';
import 'package:kwtd/models/mentor.dart';
import 'package:kwtd/services/alert_dialog.dart';
import 'package:http/http.dart' as http;

class MentorProfileEdit extends ConsumerStatefulWidget {
  const MentorProfileEdit({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MentorProfileEditState();
}

class _MentorProfileEditState extends ConsumerState<MentorProfileEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name = FirebaseAuth.instance.currentUser!.displayName;
  final _nameController = TextEditingController();
  final _collegeController = TextEditingController();
  final _emailController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _experienceController = TextEditingController();

  late Future<Mentor> mentor;

  List<String> _selectedTags = [];

  final List<String> _allTags = [
    'Front End',
    'Back End',
    'App Development',
    'Data Science',
    'Data Engineering',
    'UI/UX Design',
    'DevOps',
    'Cloud Computing',
    'Machine Learning',
    'Cybersecurity',
    'Blockchain',
  ];

  late String _selectedTag;

  Future<Mentor> getDetails() async {
    await dotenv.load(fileName: 'assets/.env');
    String phone = FirebaseAuth.instance.currentUser!.phoneNumber!;
    phone = phone.substring(phone.length - 10);
    var res = await http
        .get(Uri.parse('${dotenv.get('TEST_ADDRESS')}/getMentor?phone=$phone'));
    Mentor mentor = mentorFromJson(res.body);
    setState(() {
      _nameController.text = FirebaseAuth.instance.currentUser!.displayName!;
      _collegeController.text = mentor.collegeName;
      _emailController.text = mentor.email;
      _linkedinController.text = mentor.linkedinUrl;
      _experienceController.text = mentor.experience.toString();
      _selectedTags = mentor.skills;
    });
    return mentor;
  }

  @override
  void initState() {
    mentor = getDetails();
    _selectedTag = _allTags[0];
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm(Mentor? mentor) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      FirebaseAuth.instance.currentUser!
          .updateDisplayName(_nameController.text);
      mentor!.name = _nameController.text;
      mentor.collegeName = _collegeController.text;
      mentor.email = _emailController.text;
      mentor.experience = _experienceController.text as double;
      mentor.linkedinUrl = _linkedinController.text;
      mentor.skills = _selectedTags;

      if (kDebugMode) {
        print('Name: ${_nameController.text}');
        print('Undergraduate College: ${_collegeController.text}');
        print('Email: ${_emailController.text}');
        print('LinkedIn Profile: ${_linkedinController.text}');
        print('Years of Experience: ${_experienceController.text}');
        print(_selectedTags);
      }
      await dotenv.load(fileName: 'assets/.env');
      try {
        await createMentor(mentor);
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    }
  }

  void _addTag() {
    if (_selectedTags.length < 5) {
      if (_selectedTags.contains(_selectedTag)) {
        showPopUp(
          context: context,
          message: 'Cannot enter the same tag again',
        );
      } else {
        setState(() {
          _selectedTags.add(_selectedTag);
        });
      }
    } else {
      showPopUp(
        context: context,
        message: 'Cannot add more than 5 skill tags',
      );
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _selectedTags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: FutureBuilder(
        future: mentor,
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
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Name'),
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   _name = value!;
                        //   // _nameController.text = value;
                        // },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _collegeController,
                        decoration: const InputDecoration(
                          labelText: 'Undergraduate College Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your undergraduate college name';
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   _college = value!;
                        // },
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
                        // onSaved: (value) {
                        //   _email = value!;
                        // },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _linkedinController,
                        decoration: const InputDecoration(
                            labelText: 'LinkedIn Profile'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your LinkedIn profile URL';
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   _linkedin = value!;
                        // },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _experienceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: 'Years of Experience'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your years of experience';
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   _yearsOfExperience = double.parse(value!);
                        // },
                      ),
                      const SizedBox(height: 16.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: _selectedTags.map((tag) {
                          return Chip(
                            label: Text(tag),
                            onDeleted: () => _removeTag(tag),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedTag,
                              items: _allTags.map((tag) {
                                return DropdownMenuItem<String>(
                                  value: tag,
                                  child: Text(tag),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedTag = newValue!;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Add Tag',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _addTag,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          _submitForm(snapshot.data);
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
