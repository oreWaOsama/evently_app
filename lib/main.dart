import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/app_theme.dart';
import 'package:evently_app/feature/auth/login/login_screen.dart';
import 'package:evently_app/feature/auth/signup/signup_screen.dart';
import 'package:evently_app/feature/home/home_screen.dart';
import 'package:evently_app/feature/home/taps/create_event/create_event.dart';
import 'package:evently_app/feature/lets_start/start_screen.dart';
import 'package:evently_app/firebase_options.dart';

import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(languageProvider.currentLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.currentTheme,
      initialRoute: HomeScreen.routeName,
      routes: {
        StartScreen.routeName: (context) => const StartScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        CreateEvent.routeName: (context) => CreateEvent(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignupScreen.routeName: (context) => SignupScreen(),
      },
      home: StartScreen(),
    );
  }
}
