import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/assets_manager.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return OutlinedButton(
      onPressed: () {
        // Add your Google login logic here
      },
      style: OutlinedButton.styleFrom(
        minimumSize: Size(size.width, size.height * 0.06),
        side: const BorderSide(color: ColorsManager.primaryLight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        backgroundColor: ColorsManager.transparentColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AssetsManager.iconGoogle, height: 20, width: 20),
          const SizedBox(width: 10),
          Text(tr('login_with_google'), style: TextStyles.medium16Primary),
        ],
      ),
    );
  }
}
