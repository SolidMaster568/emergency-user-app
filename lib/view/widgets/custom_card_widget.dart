import 'package:cached_network_image/cached_network_image.dart';
import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget(
      {super.key,
      required this.onTap,
      required this.iconData,
      required this.label,
      this.isSelected = false,
      required this.iconColor});
  final String iconData;
  final String label;
  final bool isSelected;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.3,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? offRedButton : ghostWhite,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: colorSnow,
              blurRadius: 0.5,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CachedNetworkImage(
                imageUrl: iconData,
                imageBuilder: ((context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                    )),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const CircleAvatar(),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: isSelected ? colorWhite : gray),
            ),
          ],
        ),
      ),
    );
  }
}
