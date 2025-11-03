import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/assets_manager.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:evently_app/core/utils/dialog_utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_buttom.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/feature/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = 'signup_screen';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AssetsManager.logo),

                SizedBox(height: size.height * 0.05),
                CustomTextFormField(
                  prefixIcon: Image.asset(AssetsManager.iconName),
                  hintText: tr('name'),
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextFormField(
                  keyBoardInputType: TextInputType.emailAddress,
                  prefixIcon: Image.asset(AssetsManager.iconEmail),
                  hintText: tr('email'),
                  controller: emailController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter email';
                    } else if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(text)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextFormField(
                  obscureText: true,
                  keyBoardInputType: TextInputType.number,
                  prefixIcon: Image.asset(AssetsManager.iconPassword),
                  suffixIcon: Image.asset(AssetsManager.iconShowPassword),
                  hintText: tr('password'),
                  controller: passwordController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter password';
                    } else if (text.length < 6) {
                      return 'password should be at least 6 chars.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextFormField(
                  obscureText: true,
                  keyBoardInputType: TextInputType.number,
                  prefixIcon: Image.asset(AssetsManager.iconPassword),
                  suffixIcon: Image.asset(AssetsManager.iconShowPassword),
                  hintText: tr('re_password'),
                  controller: rePasswordController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter password';
                    } else if (text.length < 6) {
                      return 'password should be at least 6 chars.';
                    } else if (text != passwordController.text) {
                      return "re-password doesn't match password";
                    }

                    return null;
                  },
                ),

                SizedBox(height: size.height * 0.02),
                CustomElevatedButtom(
                  onPressed: () {
                    signup();
                  },
                  text: tr('create_account'),
                ),
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
        ),
      ),
    );
  }

  void signup() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: 'Loading.....');
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: 'Signup successfully..',
          title: 'Success',
          posActionName: 'Ok',
          posAction: (){
              Navigator.of(context).pushNamed(HomeScreen.routeName);
          }
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: 'The password provided is too weak.',
            title: 'Error',
            posActionName: 'Ok',
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            title: 'Error',
            posActionName: 'Ok',
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: 'The account already exists for that email.',
          title: 'Error',
          posActionName: 'Ok',
        );
        print(e.toString());
        print(e);
      }
    }
  }
}
