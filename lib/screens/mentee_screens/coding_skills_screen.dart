import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/controllers/mentee_controller.dart';
import 'package:kwtd/controllers/user_details.dart';
import 'package:kwtd/services/alert_dialog.dart';

class CodingSkillScreen extends ConsumerStatefulWidget {
  const CodingSkillScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CodingSkillScreenState();
}

class _CodingSkillScreenState extends ConsumerState<CodingSkillScreen> {
  late String _selectedRating;

  @override
  void initState() {
    super.initState();
    _selectedRating = 'None';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A few questions'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How would you rate your coding logic?',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            RadioListTile<String>(
              title: const Text('Bellow Average'),
              value: 'Below Average',
              groupValue: _selectedRating,
              onChanged: (value) {
                setState(() {
                  _selectedRating = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Average'),
              value: 'Average',
              groupValue: _selectedRating,
              onChanged: (value) {
                setState(() {
                  _selectedRating = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Good'),
              value: 'Good',
              groupValue: _selectedRating,
              onChanged: (value) {
                setState(() {
                  _selectedRating = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _validateAndSubmit,
              child: const Center(
                child: Text('Save Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndSubmit() {
    if (_selectedRating == 'None') {
      showPopUp(
        context: context,
        message: 'Please select a rating',
      );
      return;
    }

    try {
      // overwriting on old answer
      ref.watch(menteeUserProvider.notifier).state.answers[1] = _selectedRating;
    } catch (error) {
      // adding new answer when there is no old answer
      ref.watch(menteeUserProvider.notifier).state.answers.add(_selectedRating);
    }
    try {
      updateMentee(ref.read(menteeUserProvider));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (error) {
      showPopUp(
        context: context,
        message: error.toString(),
      );
    }
    if (kDebugMode) {
      print('Selected rating: $_selectedRating');
    }
  }
}
