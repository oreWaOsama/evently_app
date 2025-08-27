import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtom extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const CustomElevatedButtom({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height * 0.06), // Full width button
        backgroundColor:
            ColorsManager.primaryLight, // Change to your desired color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        text,
        style: TextStyles.medium20White, // Adjust text style as needed
      ),
    );
  }
}
