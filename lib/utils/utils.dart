import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:emg/models/admin_model.dart';
import 'package:emg/models/category_model.dart';
import 'package:emg/models/user_model.dart';
import 'package:emg/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:emg/utils/const.dart';

/// Image Picker Code
Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  } else {
    debugPrint('No Image Selected');
    return null;
  }
}

/// SnakBar Code
showSnakBar(String contexts, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(contexts)));
}

class Util {
  static Future<void> updateDeviceToken() async {
    if (Globals.deviceToken != "" &&
        Globals.currentUser!.devicetoken != Globals.deviceToken) {
      try {
        final http.Response response =
            await http.post(Uri.parse("$kServerUrl/user/device_token"),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String, dynamic>{
                  "uid": Globals.currentUser!.uid,
                  "devicetoken": Globals.deviceToken,
                }));

        Map<String, dynamic> result = json.decode(response.body);
        print(result["status"]);
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<UserModel?> getUserByFirebase(String uid) async {
    try {
      final http.Response response = await http.get(
        Uri.parse("$kServerUrl/user/firebase/$uid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      Map<String, dynamic> result = json.decode(response.body);

      if (result["status"] == "success") {
        return UserModel.fromJson(result["data"]);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<AdminModel?> getEmrByFirebase(String uid) async {
    try {
      final http.Response response = await http.get(
        Uri.parse("$kServerUrl/emr/firebase/$uid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      Map<String, dynamic> result = json.decode(response.body);

      if (result["status"] == "success") {
        return AdminModel.fromJson(result["data"]);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<CategoryModel>> gtCategories() async {
    try {
      final http.Response response = await http.get(
        Uri.parse("$kServerUrl/user/emergency/categories"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      Map<String, dynamic> result = json.decode(response.body);

      if (result["status"] == "success") {
        return result["data"]
            .map<CategoryModel>((e) => CategoryModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<AdminModel>> gtEmrsForCategory(String categoryID) async {
    try {
      final http.Response response = await http.post(
          Uri.parse("$kServerUrl/user/emergencies_for_category"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"category_id": categoryID}));

      Map<String, dynamic> result = json.decode(response.body);

      if (result["status"] == "success") {
        return result["data"]
            .map<AdminModel>((e) => AdminModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<Map<String, dynamic>> getAgoraToken(String channelName) async {
    try {
      final http.Response response = await http.post(
          Uri.parse("$kServerUrl/agora_token"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "uid": Globals.currentUser!.uid,
            "channelName": channelName
          }));

      Map<String, dynamic> result = json.decode(response.body);

      if (result["status"] == "success") {
        return result["data"];
      } else {
        return {};
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}
