import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/feature/home/taps/home_tab/widgets/event_card.dart';
import 'package:flutter/material.dart';

class FaviorteTab extends StatelessWidget {
  const FaviorteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: CustomTextFormField(
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorsManager.primaryLight,
                ),
                borderColor: ColorsManager.primaryLight,
                hintText: tr('search_for_event'),
                hintStyle: TextStyles.bold14Primary,
              ),
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return EventCard();
                },
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemCount: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
