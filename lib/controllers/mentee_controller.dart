import 'package:kwtd/models/mentee.dart';
import 'package:http/http.dart' as http;

Future<Mentee> getMenteeDetails() async {
  var res = await http.get('http://192.168.29.6:8080/mentor' as Uri);
  return menteeFromJson(res.body);
}
