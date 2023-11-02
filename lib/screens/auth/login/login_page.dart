import 'package:emg/screens/auth/forgot/forgot_password_page.dart';
import 'package:emg/screens/dashboard/main_dashboard.dart';
import 'package:emg/services/firestore_auth_methods.dart';
import 'package:emg/utils/buttons.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/utils/controllers.dart';
import 'package:emg/utils/decorations.dart';
import 'package:emg/utils/textformfield.dart';
import 'package:emg/utils/utils.dart';
import 'package:emg/view/widgets/top_logo_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TopLogoWidget(),
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
                        controller: loginEmailController,
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
                        Icons.lock,
                        color: colorWhite,
                      )),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormInputField(
                        controller: loginPasswordController,
                        hintText: "Enter Password",
                        textInputType: TextInputType.visiblePassword),
                  ),
                ]),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ForgotPasswordPage()));
                  },
                  child: const Text(
                    "Forgot password",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SaveButton(
                      title: "Sign In",
                      onTap: loginUser,
                    )
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    String email = loginEmailController.text.trim();
    String pass = loginPasswordController.text;

    if (email.isEmpty) {
      showSnakBar("Please input email address", context);
      return;
    }

    if (pass.isEmpty) {
      showSnakBar("Please input password", context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await AuthMethods().loginUpUser(email: email, pass: pass).then((rse) {
      debugPrint(rse);
      setState(() {
        _isLoading = false;
      });
      if (rse == 'success') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) => const MainScreen()));
      } else {
        showSnakBar(rse, context);
      }
    });
  }
}
