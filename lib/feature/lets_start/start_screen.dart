

import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/assets_manager.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:evently_app/feature/auth/login/login_screen.dart';
import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';  

class StartScreen extends StatefulWidget {
  static const String routeName = '/start_screen';
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
    
  static const _kOnboardingDone = 'onboarding_done';
  static const _kLang = 'app_lang';   // 'ar' | 'en'
  static const _kTheme = 'app_theme'; // 'light' | 'dark'

  late int selectedLanguageIndex;
  late int selectedThemeIndex;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final langCode = context.locale.languageCode;
      selectedLanguageIndex = langCode == 'ar' ? 0 : 1;

      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      selectedThemeIndex = themeProvider.currentTheme == ThemeMode.dark ? 1 : 0;

      _initialized = true;
    }
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();

    final lang = selectedLanguageIndex == 0 ? 'ar' : 'en';
    final theme = selectedThemeIndex == 0 ? 'light' : 'dark';

    await prefs.setString(_kLang, lang);
    await prefs.setString(_kTheme, theme);
    await prefs.setBool(_kOnboardingDone, true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(AssetsManager.logoTop),
              SizedBox(height: height * 0.05),
              Image.asset(
                AssetsManager.introHeader,
                width: 371,
                height: 371,
                fit: BoxFit.cover,
              ),
              SizedBox(height: height * 0.05),
              Text(
                tr('personalize_your_experience'),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: ColorsManager.primaryLight,
                ),
              ),
              SizedBox(height: height * 0.03),
              Text(
                tr('choose_your_preferred_theme_and_language_to_get_started_with_a_comfortable,_tailored_experience_that_suits_your_style'),
                style: themeProvider.currentTheme == ThemeMode.light
                    ? Theme.of(context).textTheme.bodyLarge
                    : Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                maxLines: 3,
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tr('language'), style: TextStyles.bold16Primary),
                  ToggleSwitch(
                    minWidth: 70.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [ColorsManager.primaryLight],
                      [ColorsManager.primaryLight],
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: ColorsManager.whiteBgColor,
                    inactiveFgColor: ColorsManager.primaryDark,
                    initialLabelIndex: selectedLanguageIndex,
                    totalSwitches: 2,
                    labels: [tr('arabic'), tr('english')],
                    radiusStyle: true,
                    onToggle: (index) {
                      if (index == null) return;
                      setState(() => selectedLanguageIndex = index);
                      final locale = index == 0 ? const Locale('ar') : const Locale('en');
                      context.setLocale(locale);
                      languageProvider.setLanguage(locale.languageCode);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tr('theme'), style: TextStyles.bold16Primary),
                  ToggleSwitch(
                    minWidth: 70.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [ColorsManager.primaryDark],
                      [ColorsManager.primaryLight],
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: ColorsManager.whiteBgColor,
                    inactiveFgColor: ColorsManager.primaryDark,
                    initialLabelIndex: selectedThemeIndex,
                    totalSwitches: 2,
                    labels: [tr('light'), tr('dark')],
                    radiusStyle: true,
                    onToggle: (index) {
                      if (index == null) return;
                      setState(() => selectedThemeIndex = index);
                      themeProvider.changeTheme(index == 0 ? ThemeMode.light : ThemeMode.dark);
                    },
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              ElevatedButton(
                onPressed: _completeOnboarding, 
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(width * 0.9, height * 0.06),
                  backgroundColor: ColorsManager.primaryLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(tr("let's_started"), style: TextStyles.bold16White),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
