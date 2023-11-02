import 'package:emg/screens/auth/profile/save_profile.dart';
import 'package:emg/utils/buttons.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/view/widgets/profile/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String selectedDate = "DD - MM - YY";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: gray,
                            size: 24,
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Edit Profile",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Profile data:",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.timelapse_outlined,
                        color: offRedButton,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "60 %",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        selectedDate,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              Row(
                children: [
                  const Expanded(
                    child: ProfileItemWidget(
                      subtitle: "26 years",
                      title: "Age:",
                      path: "assets/calendar.png",
                      iconColor: chryslerBlue,
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 0.5,
                    color: Colors.black,
                  ),
                  const Expanded(
                    child: ProfileItemWidget(
                      subtitle: "O +",
                      title: "Blood type:",
                      path: "assets/blood.png",
                      iconColor: offRedButton,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Expanded(
                    child: ProfileItemWidget(
                      subtitle: "180 cm",
                      title: "Height:",
                      path: "assets/height.png",
                      iconColor: hunyadiYellow,
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 0.5,
                    color: Colors.black,
                  ),
                  const Expanded(
                    child: ProfileItemWidget(
                      subtitle: "85 kg",
                      title: "Weight:",
                      path: "assets/weight.png",
                      iconColor: vividSkyBlue,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Allergies and reactions",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: colorBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.email,
                        color: offRedButton,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "johndoe@doe.com",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: gray),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.phone,
                        color: offRedButton,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "0701-258-2582",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: gray),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              Text(
                "Grape",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: colorBlack),
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              SaveButton(
                title: "Save",
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SaveProfileScreen())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: offRedButton,
              // onPrimary: offRedButton,
              // onSurface: ghostWhite,
              onPrimary: ghostWhite,

              // surface: ghostWhite,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: offRedButton, // button text color
                foregroundColor: colorWhite,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    final format = DateFormat("dd - MM - yy");
    if (picked != null && format.format(picked) != selectedDate) {
      setState(() {
        selectedDate = format.format(picked);
      });
    }
  }
}
