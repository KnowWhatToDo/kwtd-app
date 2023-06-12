import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kwtd/models/mentor.dart';

Future<Mentor> getMentor(String number) async {
  await dotenv.load(fileName: 'assets/.env');
  var res = await http.get(
    Uri.parse('${dotenv.get('TEST_ADDRESS')}/getMentee?phone=$number'),
  );
  return mentorFromJson(res.body);
}

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
