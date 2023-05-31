import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenteeProfielEdit extends ConsumerStatefulWidget {
  const MenteeProfielEdit({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MenteeProfielEditState();
}

class _MenteeProfielEditState extends ConsumerState<MenteeProfielEdit> {
  String? name = FirebaseAuth.instance.currentUser!.displayName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  final List<String> _branches = [
    'Computer Science',
    'Mechanical',
    'Electrical',
    'Civil',
    'Other'
  ];

  late String _name;
  late String _year;
  late String _branch;
  late String _college;
  late String _linkedinURL;

  @override
  void initState() {
    _name = '';
    _year = _years[0];
    _branch = _branches[0];
    _college = '';
    _linkedinURL = '';
    super.initState();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (kDebugMode) {
        print('Name: $_name');
        print('Year: $_year');
        print('Branch: $_branch');
        print('College: $_college');
        print('LinkedIn: $_linkedinURL');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                DropdownButtonFormField<String>(
                  value: _year,
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
                      _year = value!;
                    });
                  },
                  onSaved: (value) {
                    _year = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _branch,
                  items: _branches.map((String branch) {
                    return DropdownMenuItem<String>(
                      value: branch,
                      child: Text(branch),
                    );
                  }).toList(),
                  decoration:
                      const InputDecoration(labelText: 'Branch of Engineering'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your branch of engineering';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _branch = value!;
                    });
                  },
                  onSaved: (value) {
                    _branch = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Name of College'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the name of your college';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _college = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'LinkedIn Profile URL'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your LinkedIn profile URL';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _linkedinURL = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
