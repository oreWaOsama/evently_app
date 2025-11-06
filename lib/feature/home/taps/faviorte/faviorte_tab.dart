import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/feature/home/taps/home_tab/widgets/event_card.dart';

import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FaviorteTab extends StatelessWidget {
  const FaviorteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if (eventListProvider.favoriteEventsFilteredList.isEmpty) {
      eventListProvider.getAllFavoriteEvents(userProvider.currentUser!.id);
    }
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
              child: eventListProvider.favoriteEventsFilteredList.isEmpty
                  ? Center(
                      child: Text(
                        tr('no_favorite_events'),
                        style: TextStyles.bold20Primary,
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return EventCard(
                          event: eventListProvider
                              .favoriteEventsFilteredList[index],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount:
                          eventListProvider.favoriteEventsFilteredList.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
