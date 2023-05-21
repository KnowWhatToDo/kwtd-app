import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneNumberStateProvider = StateProvider<String>((ref) {
  return '+911122334455';
});

final mentorStateProvider = StateProvider<bool>((ref) {
  return false;
});

final userDisplayNameProvider = StateProvider<String>((ref) {
  return 'mentor';
});
