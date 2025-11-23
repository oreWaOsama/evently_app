import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/app_theme.dart';
import 'package:evently_app/feature/auth/login/login_screen.dart';
import 'package:evently_app/feature/auth/signup/signup_screen.dart';
import 'package:evently_app/feature/home/home_screen.dart';
import 'package:evently_app/feature/home/taps/create_event/create_event.dart';
import 'package:evently_app/feature/lets_start/start_screen.dart';
import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(languageProvider.currentLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.currentTheme,
      routes: {
        StartScreen.routeName: (_) => const StartScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        CreateEvent.routeName: (_) => CreateEvent(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        SignupScreen.routeName: (_) => const SignupScreen(),
      },

      home: const StartDecider(),
    );
  }
}

class StartDecider extends StatefulWidget {
  const StartDecider({super.key});

  @override
  State<StartDecider> createState() => _StartDeciderState();
}

class _StartDeciderState extends State<StartDecider> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('onboarding_done') ?? false;

    if (!seen) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, StartScreen.routeName);
      return;
    }

    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is logged in, fetch details
      var myUser = await FirebaseUtils.readUserFromFireStore(user.uid);
      if (myUser != null) {
        if (!mounted) return;
        Provider.of<UserProvider>(context, listen: false).updatUser(myUser);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        return;
      }
    }

    // Not logged in or user fetch failed
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
