import 'package:cached_network_image/cached_network_image.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/utils/globals.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key, this.height, this.width});

  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 60,
      height: height ?? 60,
      child: CachedNetworkImage(
        imageUrl: Globals.currentUser!.photourl,
        imageBuilder: ((context, imageProvider) => Container(
              decoration: BoxDecoration(
                  color: colorSnow,
                  borderRadius: width != null
                      ? BorderRadius.circular(8)
                      : BorderRadius.circular(12),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            )),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: colorSnow,
            borderRadius: width != null
                ? BorderRadius.circular(8)
                : BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.person,
            color: colorWhite,
            size: width ?? 50,
          ),
        ),
      ),
    );
  }
}
