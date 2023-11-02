import 'package:emg/screens/auth/forgot/reset_password_page.dart';
import 'package:emg/utils/buttons.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/utils/controllers.dart';
import 'package:emg/utils/decorations.dart';
import 'package:emg/utils/textformfield.dart';
import 'package:emg/view/widgets/top_logo_widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopLogoWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SaveButton(
                        title: "Reset Password",
                        onTap: signUpUser,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (builder) => const ResetPasswordPage()));
    setState(() {
      isLoading = false;
    });
    // await AuthMethods().resetPassword(email: firstEmailController.text).then((rse) {
    //   debugPrint(rse.name);
    //   setState(() {
    //     isLoading = false;
    //   });
    //   if (rse != AuthStatus.successful) {
    //     showSnakBar(rse.name, context);
    //   } else {
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (builder) => const ResetPasswordPage()));
    //   }
    // });
  }
}
