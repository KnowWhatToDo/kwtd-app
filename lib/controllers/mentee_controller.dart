import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kwtd/models/mentee.dart';
import 'package:http/http.dart' as http;

Future<Mentee> getMentee(String number) async {
  await dotenv.load(fileName: 'assets/.env');
  var res = await http.get(
    Uri.parse('${dotenv.get('TEST_ADDRESS')}/getMentee?phone=$number'),
  );
  return menteeFromJson(res.body);
}

Future<void> createMentee(Mentee mentee) async {
  await dotenv.load(fileName: 'assets/.env');
  await http.post(
    Uri.parse('${dotenv.get('TEST_ADDRESS')}/addMentee'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: menteeToJson(mentee),
  );
}

Future<void> updateMentee(Mentee mentee) async {
  await http.post(
    Uri.parse('${dotenv.get('TEST_ADDRESS')}/addMentee'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: menteeToJson(mentee),
  );
}
