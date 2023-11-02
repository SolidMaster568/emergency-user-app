import 'dart:convert';
import 'dart:typed_data';

import 'package:emg/models/user_model.dart';
import 'package:emg/services/storage_methods.dart';
import 'package:emg/utils/globals.dart';
import 'package:emg/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'firebase_exceptions.dart';
import 'package:emg/utils/const.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Register User with Add User
  Future<String> signUpUser(
      {required String email,
      required String pass,
      required String firstname,
      required String lastname,
      required String phoneNumber,
      required Uint8List file}) async {
    String res = 'Some error occured';
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      String photoURL = await StorageMethods()
          .uploadImageToStorage('ProfilePics', file, false);
      //Add User to the database with modal
      final http.Response response =
          await http.post(Uri.parse("$kServerUrl/user/auth/register"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{
                "uid": cred.user!.uid,
                "firstname": firstname,
                "lastname": lastname,
                "email": email,
                "password": pass,
                "mobile": phoneNumber,
                "photourl": photoURL,
              }));

      Map<String, dynamic> result = json.decode(response.body);

      if (result["status"] == "success") {
        Globals.currentUser = UserModel.fromJson(result["data"]);
        Util.updateDeviceToken();
      } else {
        debugPrint(result["status"]);
        Globals.currentUser = UserModel.fromJson({"uid": cred.user!.uid});
      }

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  ///Login User with Add Useer
  Future<String> loginUpUser({
    required String email,
    required String pass,
  }) async {
    String res = 'Some error occured';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);

      User user = FirebaseAuth.instance.currentUser!;
      UserModel? userModel = await Util.getUserByFirebase(user.uid);

      if (userModel != null) {
        Globals.currentUser = userModel;
        Util.updateDeviceToken();
      } else {
        Globals.currentUser = UserModel.fromJson({"uid": user.uid});
      }

      res = 'success';
    } on FirebaseException catch (e) {
      if (e.message == 'WrongEmail') {
        debugPrint(e.message ?? "");
      }
      if (e.message == 'WrongPassword') {
        debugPrint(e.message ?? "");
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  /// Forgot Password
  Future<AuthStatus> resetPassword({required String email}) async {
    AuthStatus status = AuthStatus.invalidEmail;
    await _auth
        .sendPasswordResetEmail(email: email)
        .then((value) => status = AuthStatus.successful)
        .catchError(
            (e) => status = AuthExceptionHandler.handleAuthException(e));

    return status;
  }
}
