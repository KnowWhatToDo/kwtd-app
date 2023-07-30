import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kwtd/models/mentee.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

/// Gets the details of a mentee by the individiual's number
/// [param] Takes [String] number as parameter
/// [returns] a [Future] of [Mentee] object with details of the Mentee
Future<Mentee> getMentee(String number) async {
  await dotenv.load(fileName: 'assets/.env');
  late http.Response res;
  try {
    res = await http.get(
      Uri.parse('${dotenv.get('TEST_ADDRESS')}/getMentee?phone=$number'),
    );
  } catch (error) {
    if (kDebugMode) {
      print(error);
    }
  }
  return menteeFromJson(res.body);
}

/// Creates a [Mentee] in the database
/// [param] Take [Mentee] object as a parameter
/// [returns] nothing
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

/// Updates an existing [Mentee] in the database
/// [param] Take [Mentee] object as a parameter
/// [returns] nothing
Future<void> updateMentee(Mentee mentee) async {
  await http.post(
    Uri.parse('${dotenv.get('TEST_ADDRESS')}/addMentee'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: menteeToJson(mentee),
  );
}
