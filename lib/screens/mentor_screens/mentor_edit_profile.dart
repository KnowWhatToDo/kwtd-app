import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/services/alert_dialog.dart';

class MentorProfileEdit extends ConsumerStatefulWidget {
  const MentorProfileEdit({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MentorProfileEditState();
}

class _MentorProfileEditState extends ConsumerState<MentorProfileEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name = FirebaseAuth.instance.currentUser!.displayName;
  late String _name;
  late String _college;
  late String _email;
  late String _linkedin;
  late double _yearsOfExperience;

  final List<String> _selectedTags = [];
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

  final TextEditingController _textEditingController = TextEditingController();
  late String _selectedTag;

  @override
  void initState() {
    _selectedTag = _allTags[0];
    _name = '';
    _college = '';
    _email = '';
    _linkedin = '';
    _yearsOfExperience = 0;
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (kDebugMode) {
        print('Name: $_name');
        print('Undergraduate College: $_college');
        print('Email: $_email');
        print('LinkedIn Profile: $_linkedin');
        print('Years of Experience: $_yearsOfExperience');
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Undergraduate College Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your undergraduate college name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _college = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
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
                    _email = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'LinkedIn Profile'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your LinkedIn profile URL';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _linkedin = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Years of Experience'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your years of experience';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _yearsOfExperience = double.parse(value!);
                  },
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
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
