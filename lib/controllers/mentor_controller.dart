import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kwtd/models/mentor.dart';

/// Gets the details of a [Mentor] by the individiual's number
/// [param] Takes [String] number as parameter
/// [returns] a [Future] of [Mentor] object with details of the Mentee
Future<Mentor> getMentor(String number) async {
  await dotenv.load(fileName: 'assets/.env');
  var res = await http.get(
    Uri.parse('${dotenv.get('TEST_ADDRESS')}/getMentee?phone=$number'),
  );
  return mentorFromJson(res.body);
}

/// Creates a [Mentor] in the database
/// [param] Take [Mentor] object as a parameter
/// [returns] nothing
Future<void> createMentor(Mentor mentor) async {
  await dotenv.load(fileName: 'assets/.env');
  await http.post(
    Uri.parse('${dotenv.get('TEST_ADDRESS')}/addMentor'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: mentorToJson(mentor),
  );
}

/// Updates an existing [Mentor] in the database
/// [param] Take [Mentor] object as a parameter
/// [returns] nothing
Future<void> updateMentee(Mentor mentor) async {
  await dotenv.load(fileName: 'assets/.env');
  await http.post(
    Uri.parse('${dotenv.get('TEST_ADDRESS')}/addMentor'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: mentorToJson(mentor),
  );
}
