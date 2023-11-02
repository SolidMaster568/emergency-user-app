import 'dart:typed_data';

import 'package:emg/screens/auth/login/login_page.dart';
import 'package:emg/services/firestore_auth_methods.dart';
import 'package:emg/utils/buttons.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/utils/controllers.dart';
import 'package:emg/utils/decorations.dart';
import 'package:emg/utils/textformfield.dart';
import 'package:emg/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Uint8List? _image;

  //Looding Variable
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 59,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 59, backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 59,
                          backgroundImage: NetworkImage(
                              'https://static.remove.bg/remove-bg-web/a6eefcd21dff1bbc2448264c32f7b48d7380cb17/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png'),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 70,
                      child: IconButton(
                          onPressed: () => selectImage(),
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: lightRed,
                          )))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: leadingDecoration,
                      child: const Icon(
                        Icons.person,
                        color: colorWhite,
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormInputField(
                        controller: firstNameController,
                        hintText: "Enter First Name",
                        textInputType: TextInputType.emailAddress),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: leadingDecoration,
                      child: const Icon(
                        Icons.person,
                        color: colorWhite,
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormInputField(
                        controller: firstLastController,
                        hintText: "Enter Last Name",
                        textInputType: TextInputType.emailAddress),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: leadingDecoration,
                      child: const Icon(
                        Icons.email,
                        color: colorWhite,
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormInputField(
                        controller: firstEmailController,
                        hintText: "Enter Email",
                        textInputType: TextInputType.emailAddress),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: leadingDecoration,
                      child: const Icon(
                        Icons.phone,
                        color: colorWhite,
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormInputField(
                        controller: firstPhoneController,
                        hintText: "Enter Phone Number",
                        textInputType: TextInputType.number),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: leadingDecoration,
                      child: const Icon(
                        Icons.password,
                        color: colorWhite,
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormInputField(
                        controller: firstPasswordController,
                        hintText: "Enter Password",
                        textInputType: TextInputType.visiblePassword),
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SaveButton(
                      title: "SignUp",
                      onTap: signUpUser,
                    )
            ],
          ),
        ),
      ),
    );
  }

  selectImage() async {
    Uint8List? ui = await pickImage(ImageSource.gallery);
    if (ui != null) {
      setState(() {
        _image = ui;
      });
    }
  }

  void signUpUser() async {
    String firstName = firstNameController.text.trim();
    String lastName = firstLastController.text.trim();
    String email = firstEmailController.text.trim();
    String pass = firstPasswordController.text;
    String phoneNumber = firstPhoneController.text.trim();

    if (_image == null) {
      showSnakBar("Please select profile image", context);
      return;
    }

    if (email.isEmpty) {
      showSnakBar("Please input email address", context);
      return;
    }

    if (pass.isEmpty) {
      showSnakBar("Please input password", context);
      return;
    }

    if (firstName.isEmpty) {
      showSnakBar("Please input first name", context);
      return;
    }

    if (lastName.isEmpty) {
      showSnakBar("Please input last name", context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await AuthMethods()
        .signUpUser(
            phoneNumber: phoneNumber,
            email: email,
            pass: pass,
            firstname: firstName,
            lastname: lastName,
            file: _image!)
        .then((rse) {
      debugPrint(rse);
      setState(() {
        _isLoading = false;
      });
      if (rse != 'success') {
        showSnakBar(rse, context);
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) => const LoginPage()));
      }
    });
  }
}
