import 'package:http/http.dart' as http;
import 'package:kwtd/models/mentor.dart';

Future<Mentor> getMentorDetails() async {
  var res = await http.get(Uri.parse('<addr>/Mentor'));
  return mentorFromJson(res.body);
}
