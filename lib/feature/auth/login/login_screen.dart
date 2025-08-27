import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/assets_manager.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:evently_app/core/widgets/custom_elevated_buttom.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/feature/auth/login/widget/google_login_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(AssetsManager.logo),

              SizedBox(height: size.height * 0.05),
              CustomTextFormField(
                prefixIcon: Image.asset(AssetsManager.iconEmail),
                hintText: tr('email'),
                controller: emailController,
                validator: (text) {},
              ),
              SizedBox(height: size.height * 0.02),
              CustomTextFormField(
                prefixIcon: Image.asset(AssetsManager.iconPassword),
                suffixIcon: Image.asset(AssetsManager.iconShowPassword),
                hintText: tr('password'),
                controller: passwordController,
                validator: (text) {},
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      tr('forget_password'),
                      style: TextStyles.bold16Primary.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManager.primaryLight,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              CustomElevatedButtom(onPressed: () {}, text: tr('login')),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr('don’t_have_account'),
                    style: TextStyles.medium16White,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('signup_screen');
                    },
                    child: Text(
                      tr('create_account'),
                      style: TextStyles.bold16Primary.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManager.primaryLight,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ColorsManager.primaryLight,
                      thickness: 2,
                      indent: size.width * 0.02,
                      endIndent: size.width * 0.02,
                    ),
                  ),
                  Text(tr('or'), style: TextStyles.bold16Primary),
                  Expanded(
                    child: Divider(
                      color: ColorsManager.primaryLight,
                      thickness: 2,
                      indent: size.width * 0.02,
                      endIndent: size.width * 0.02,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              GoogleLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
