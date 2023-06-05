import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final phoneNumberStateProvider = StateProvider<String>((ref) {
  return '+911122334455';
});

final mentorStateProvider = StateProvider<bool>((ref) {
  return false;
});

final usernameProvider = StateProvider<String>((ref) {
  return '';
});

final envProvider =
    FutureProvider((ref) => dotenv.load(fileName: 'assets/.env'));
