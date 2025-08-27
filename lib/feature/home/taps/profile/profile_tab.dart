import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/assets_manager.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:evently_app/core/utils/local_keys.dart';
import 'package:evently_app/feature/home/taps/profile/language_bottom_sheet.dart';
import 'package:evently_app/feature/home/taps/profile/theme_bottom_sheet%20copy.dart';
import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(72)),
        ),
        toolbarHeight: height * 0.18,
        title: Row(
          children: [
            Image.asset(
              AssetsManager.routeImage,
              width: width * 0.25,
              height: height * 0.25,
              fit: BoxFit.contain,
            ),
            SizedBox(width: width * 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Osama Gabr',
                    style: TextStyles.bold24White,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'osamagabr204@gmail.com',
                    style: TextStyles.bold16White,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),

        backgroundColor: ColorsManager.primaryLight,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              tr('language'),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            InkWell(
              onTap: () {
                showLanguageBottomSheet(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorsManager.primaryLight,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.currentLanguage == 'ar'
                          ? tr('arabic')
                          : tr('english'),
                      style: TextStyles.bold20Primary,
                    ),

                    Icon(
                      Icons.arrow_drop_down,
                      color: ColorsManager.primaryLight,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              LocalKeys.theme.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            InkWell(
              onTap: () {
                showThemeBottomSheet(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorsManager.primaryLight,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.currentTheme == ThemeMode.light
                          ? tr('light')
                          : tr('dark'),
                      style: TextStyles.bold20Primary,
                    ),

                    Icon(
                      Icons.arrow_drop_down,
                      color: ColorsManager.primaryLight,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width, height * 0.07),

                backgroundColor: ColorsManager.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.logout, color: ColorsManager.whiteColor),
                  SizedBox(width: width * 0.02),
                  Text(tr('logout'), style: TextStyles.regular20White),
                ],
              ),
            ),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => LanguageBottomSheet(),
  );
}

void showThemeBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => ThemeBottomSheet(),
  );
}
