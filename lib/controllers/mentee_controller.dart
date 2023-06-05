import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kwtd/models/mentee.dart';
import 'package:http/http.dart' as http;

Future<Mentee> getMenteeDetails() async {
  var res = await http.get('<api_addr>/mentor' as Uri);
  return menteeFromJson(res.body);
}

Future<void> createMentee(Mentee mentee) async {
  await dotenv.load(fileName: 'assets/.env');
  await http.post(
    Uri.parse('http://${dotenv.get('address')}/addmentee'),
    body: menteeToJson(mentee),
  );
}
