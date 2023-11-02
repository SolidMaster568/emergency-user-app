import 'package:emg/utils/colors.dart';
import 'package:emg/view/widgets/chat/health_care_icon_widget.dart';
import 'package:emg/view/widgets/profile_image_widget.dart';
import 'package:flutter/material.dart';

class ChatCardWidget extends StatelessWidget {
  const ChatCardWidget(
      {super.key, required this.message, required this.alignment});

  final String message;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,
            ),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color:
                  alignment == Alignment.centerLeft ? frenchGray : ghostWhite,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Padding(
                padding: EdgeInsets.only(
                  left: alignment == Alignment.centerLeft ? 50 : 20,
                  right: alignment == Alignment.centerLeft ? 20 : 50,
                  top: 10,
                  bottom: 10,
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          if (alignment == Alignment.centerLeft)
            const Positioned(
              top: 0,
              left: 25,
              child: HealthCareIconWidget(
                width: 30,
                height: 30,
              ),
            ),
          if (alignment == Alignment.centerRight)
            const Positioned(
              top: 0,
              right: 25,
              child: ProfileImageWidget(
                width: 30,
                height: 30,
              ),
            ),
        ],
      ),
    );
  }
}
