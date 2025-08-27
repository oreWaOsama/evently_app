import 'package:evently_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class EventDateOrTime extends StatelessWidget {
  final String iconDateOrTime;
  final String eventDateorTime;
  final String textButton;
  final VoidCallback onPressed;

  const EventDateOrTime({
    super.key,
    required this.iconDateOrTime,
    required this.eventDateorTime,
    required this.textButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconDateOrTime),
        SizedBox(width: 8),
        Text(eventDateorTime, style: TextStyles.bold16Black),
        Spacer(),
        TextButton(
          onPressed: onPressed,
          child: Text(textButton, style: TextStyles.bold16Primary),
        ),
      ],
    );
  }
}
