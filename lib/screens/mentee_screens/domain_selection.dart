import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/controllers/user_details.dart';
import 'package:kwtd/models/mentee.dart';
import 'package:kwtd/screens/mentee_screens/coding_skills_screen.dart';
import 'package:kwtd/services/alert_dialog.dart';
import 'package:localstorage/localstorage.dart';

class DomainSelectionScreen extends ConsumerStatefulWidget {
  const DomainSelectionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DomainSelectionScreenState();
}

class _DomainSelectionScreenState extends ConsumerState<DomainSelectionScreen> {
  late String _firstDomain;
  late String _secondDomain;
  late String _thirdDomain;

  final List<String> _availableDomains = [
    'Mobile Development',
    'Web Development',
    'Machine Learning',
    'Data Science',
    'Cloud Computing',
    ' ',
  ];

  @override
  void initState() {
    super.initState();
    List<String> answers = ref.read(menteeUserProvider).answers[0].split(",");
    try {
      _firstDomain = answers[0];
    } catch (error) {
      _firstDomain = ' ';
    }
    try {
      _secondDomain = answers[1];
    } catch (error) {
      _secondDomain = ' ';
    }
    try {
      _thirdDomain = answers[2];
    } catch (error) {
      _thirdDomain = ' ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A few questions'),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What are your domains of interest (in order of preference)?',
                  style: TextStyle(fontSize: 24.0),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _firstDomain,
                  items: _buildDropdownItems(),
                  onChanged: (value) {
                    setState(() {
                      _firstDomain = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'First Domain *',
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _secondDomain,
                  items: _buildDropdownItems(),
                  onChanged: (value) {
                    setState(() {
                      _secondDomain = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Second Domain',
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _thirdDomain,
                  items: _buildDropdownItems(),
                  onChanged: (value) {
                    setState(() {
                      _thirdDomain = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Third Domain',
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _validateAndSubmit,
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return _availableDomains
        .map((domain) => DropdownMenuItem<String>(
              value: domain,
              child: Text(domain),
            ))
        .toList();
  }

  void _validateAndSubmit() {
    if (_firstDomain == ' ') {
      showPopUp(
        context: context,
        message: 'Please select your first preference at least',
      );
      return;
    }

    String domains = _firstDomain;
    if (_secondDomain != ' ') {
      domains += ',$_secondDomain';
    }
    if (_thirdDomain != ' ') {
      domains += ',$_thirdDomain';
    }

    try {
      // To ovewrite the old answers
      ref.watch(menteeUserProvider.notifier).state.answers[0] = domains;
    } catch (error) {
      // To add new answers if there were no old answers
      ref.watch(menteeUserProvider.notifier).state.answers.add(domains);
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CodingSkillScreen(),
      ),
    );

    if (kDebugMode) {
      print(domains);
    }
  }
}
