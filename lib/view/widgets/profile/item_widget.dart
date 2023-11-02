import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    required this.subtitle,
    required this.title,
    required this.path,
    required this.iconColor,
  });

  final String title, subtitle;
  final String path;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final data = subtitle.split(" ");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: gray),
            ),
            RichText(
              text: TextSpan(
                text: data.first,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: colorBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                children: [
                  const TextSpan(
                    text: " ",
                  ),
                  TextSpan(
                    text: data.last,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: colorBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        Image.asset(
          path,
          color: iconColor,
          width: 50,
          height: 50,
        ),
      ],
    );
  }
}
