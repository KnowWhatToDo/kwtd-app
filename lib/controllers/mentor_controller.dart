import 'package:http/http.dart' as http;
import 'package:kwtd/models/mentor.dart';

Future<Mentor> getMentorDetails() async {
  var res = await http.get(Uri.parse('http://192.168.29.6:8080/Mentor'));
  return mentorFromJson(res.body);
}
