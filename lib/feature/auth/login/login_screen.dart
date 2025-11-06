import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/assets_manager.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:evently_app/core/utils/dialog_utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_buttom.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/feature/auth/login/widget/google_login_button.dart';
import 'package:evently_app/feature/home/home_screen.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/my_user.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetsManager.logo),

                  SizedBox(height: size.height * 0.05),
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
                    keyBoardInputType: TextInputType.text,
                    obscureText: true,
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
                  CustomElevatedButtom(
                    onPressed: () {
                      login();
                      print('login suss');
                    },
                    text: tr('login'),
                  ),
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
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: 'Loading..');

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        MyUser? user = await FirebaseUtils.readUserFromFireStore(
          credential.user?.uid ?? '',
        );
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updatUser(user);

        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: 'Login successfully.',
          title: 'Success',
          posActionName: 'Ok',
          posAction: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,

            message:
                'The supplied auth credential is incorrect, malformed or has expired.',
            title: 'Error',
            posActionName: 'Ok',
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,

          message: e.toString(),
          title: 'Error',
          posActionName: 'Ok',
        );
        print(e);
      }
    }
  }
}
