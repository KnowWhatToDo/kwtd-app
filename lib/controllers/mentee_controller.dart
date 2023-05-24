import 'package:kwtd/models/mentee.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Mentee> getMenteeDetails() async {
  var res = await http.get('<api_addr>/mentor' as Uri);
  return menteeFromJson(res.body);
}
