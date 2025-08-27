import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/colors_manager.dart';

import 'package:evently_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
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
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: themeProvider.currentTheme == ThemeMode.light
                ? getSelectedTheme(tr('light'))
                : getUnselectedTheme(tr('light')),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.currentTheme == ThemeMode.dark
                ? getSelectedTheme(tr('dark'))
                : getUnselectedTheme(tr('dark')),
          ),
        ],
      ),
    );
  }

  Widget getSelectedTheme(String text) {
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

  Widget getUnselectedTheme(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(text, style: Theme.of(context).textTheme.headlineMedium)],
    );
  }
}
