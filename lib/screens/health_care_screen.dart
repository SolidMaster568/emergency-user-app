import 'package:emg/view/widgets/chat/health_care_icon_widget.dart';
import 'package:emg/view/widgets/chat/reply_card.dart';
import 'package:emg/view/widgets/custom_icon_text_button.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class HealthCareScreen extends StatefulWidget {
  const HealthCareScreen({super.key});

  @override
  State<HealthCareScreen> createState() => _HealthCareScreenState();
}

class _HealthCareScreenState extends State<HealthCareScreen> {
  final reportController = TextEditingController();

  bool isTapAttachment = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(size.width, size.height * 0.12),
          child: AppBar(
            toolbarHeight: size.height * 0.12,
            backgroundColor: ghostWhite,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: colorBlack,
              ),
            ),
            // centerTitle: true,
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.start,

              children: [
                const HealthCareIconWidget(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "112",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: colorBlack, fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                              text: " Health Care",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: offRedButton))
                        ],
                      ),
                    ),
                    // const SizedBox(height: 6,),
                    Text(
                      "Online",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: colorGrey),
                    ),
                  ],
                )
              ],
            ),
          )),
      body: Container(
        width: size.width,
        height: size.height,
        color: colorWhite,
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Expanded(
                child: ListView(
              shrinkWrap: true,
              children: const [
                ChatCardWidget(
                    message: "Hello!", alignment: Alignment.centerRight),
                ChatCardWidget(
                    message: "Hi, can we help you?",
                    alignment: Alignment.centerLeft),
              ],
            )),
            if (isTapAttachment)
              Container(
                color: ghostWhite,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.center,
                height: size.height * 0.16,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomIconTextButton(
                        iconColor: offRedButton,
                        label: "Camera",
                        iconData: Icons.camera_alt),
                    CustomIconTextButton(
                        iconColor: Colors.blue,
                        label: "Document",
                        iconData: Icons.file_present_rounded),
                    CustomIconTextButton(
                        iconColor: Colors.purple,
                        label: "Gallery",
                        iconData: Icons.image),
                  ],
                ),
              ),
            const Divider(
              color: colorWhite,
              height: 1.5,
            ),
            SafeArea(
              child: Container(
                color: ghostWhite,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: size.height * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (FocusScope.of(context).hasFocus) {
                            FocusScope.of(context).unfocus();
                          }

                          if (reportController.text.isNotEmpty) {
                            reportController.clear();
                          }

                          if (!isTapAttachment) {
                            isTapAttachment = true;
                          }

                          setState(() {});
                        },
                        child: Image.asset(
                          "assets/icons/attach.png",
                          color: colorGrey,
                          width: 30,
                          height: 30,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: reportController,
                        onTap: () {
                          if (isTapAttachment) {
                            setState(() => isTapAttachment = false);
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Report an emergency",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Image.asset(
                      "assets/icons/send.png",
                      color: offRedButton,
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
