import 'package:emg/utils/colors.dart';
import 'package:emg/view/widgets/profile_image_widget.dart';
import 'package:flutter/material.dart';

class SaveProfileScreen extends StatelessWidget {
  const SaveProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(size.width, 70),
          child: AppBar(
            toolbarHeight: 70,
            backgroundColor: ghostWhite,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: colorBlack,
              ),
            ),
            centerTitle: true,
            title: Text(
              "SETTINGS",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w900, color: colorBlack),
            ),
          )),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          color: colorWhite,
          child: Column(
            children: [
              // Container(
              //   color: ghostWhite,
              //   child: Row(
              //     children: [
              //       const SizedBox(
              //         width: 16,
              //       ),
              //       GestureDetector(
              //         onTap: () => Navigator.pop(context),
              //         child: const Icon(Icons.arrow_back_ios_new, color: colorBlack,),
              //       ),
              //       Expanded(
              //         child: Container(alignment: Alignment.center, child: Text("SETTINGS", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.w900, color: colorBlack),)),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const ProfileImageWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "John Bello",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: colorBlack),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.check,
                          size: 100,
                          color: offRedButton,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Profile Saved!",
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
