import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kwtd/models/mentee.dart';
import 'package:kwtd/models/mentor.dart';

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

final menteeUserProvider = StateProvider(
  (ref) => Mentee(
    name: "",
    phone: "",
    email: "",
    collegeName: "",
    collegeYear: "",
    collegeBranch: "",
    linkedInProfile: "",
    questions: [],
    answers: [],
    mentors: [],
    meetings: [],
  ),
);

final mentorUserProvider = StateProvider(
  (ref) => Mentor(
    phone: '',
    name: '',
    collegeName: '',
    skills: [],
    email: '',
    linkedinUrl: '',
    isVerified: false,
    experience: 0,
  ),
);
