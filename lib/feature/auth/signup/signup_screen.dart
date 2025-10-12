import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/assets_manager.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:evently_app/core/widgets/custom_elevated_buttom.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = 'signup_screen';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tr('register'), style: TextStyles.medium20Primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(AssetsManager.logo),

            SizedBox(height: size.height * 0.05),
            CustomTextFormField(
              prefixIcon: Image.asset(AssetsManager.iconName),
              hintText: tr('name'),
              controller: emailController,
              validator: (text) {
                return null;
              },
            ),
            SizedBox(height: size.height * 0.02),
            CustomTextFormField(
              prefixIcon: Image.asset(AssetsManager.iconEmail),
              hintText: tr('email'),
              controller: emailController,
              validator: (text) {
                return null;
              },
            ),
            SizedBox(height: size.height * 0.02),
            CustomTextFormField(
              prefixIcon: Image.asset(AssetsManager.iconPassword),
              suffixIcon: Image.asset(AssetsManager.iconShowPassword),
              hintText: tr('password'),
              controller: passwordController,
              validator: (text) {
                return null;
              },
            ),
            SizedBox(height: size.height * 0.02),
            CustomTextFormField(
              prefixIcon: Image.asset(AssetsManager.iconPassword),
              suffixIcon: Image.asset(AssetsManager.iconShowPassword),
              hintText: tr('re_password'),
              controller: passwordController,
              validator: (text) {
                return null;
              },
            ),

            SizedBox(height: size.height * 0.02),
            CustomElevatedButtom(onPressed: () {}, text: tr('create_account')),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr('already_have_account'),
                  style: TextStyles.medium16White,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('login_screen');
                  },
                  child: Text(
                    tr('login'),
                    style: TextStyles.bold16Primary.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: ColorsManager.primaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
