import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/colors_manager.dart';

import 'package:evently_app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              context.setLocale(Locale('ar'));
              languageProvider.setLanguage('ar');
            },
            child: languageProvider.currentLanguage == 'ar'
                ? getSelectedLanguage(tr('arabic'))
                : getUnselectedLanguage(tr('arabic')),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              context.setLocale(Locale('en'));
              languageProvider.setLanguage('en');
            },
            child: languageProvider.currentLanguage == 'en'
                ? getSelectedLanguage(tr('english'))
                : getUnselectedLanguage(tr('english')),
          ),
        ],
      ),
    );
  }

  Widget getSelectedLanguage(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: ColorsManager.primaryLight,
          ),
        ),
        Icon(Icons.check, color: ColorsManager.primaryLight, size: 35),
      ],
    );
  }

  Widget getUnselectedLanguage(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(text, style: Theme.of(context).textTheme.headlineMedium)],
    );
  }
}
