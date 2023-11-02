import 'dart:convert';

import 'package:emg/utils/const.dart';
import 'package:http/http.dart' as http;

class ProfileMethods {
  Future<String> getProfile({required String id}) async {
    String res = 'Some error occured';
    try {
      final http.Response response = await http
          .get(Uri.parse("$kServerUrl/user/$id"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      Map<String, dynamic> result = json.decode(response.body);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
