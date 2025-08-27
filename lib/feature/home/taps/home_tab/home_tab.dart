import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theming/assets_manager.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:evently_app/feature/home/taps/home_tab/widgets/event_card.dart';
import 'package:evently_app/feature/home/taps/home_tab/widgets/events_tabs_item.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  List<String> eventsName = [
    tr('all'),
    tr('sport'),
    tr('birthday'),
    tr('meeting'),
    tr('gaming'),
    tr('workshop'),
    tr('book_club'),
    tr('exhibition'),
    tr('holiday'),
    tr('eating'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tr('welcome_back'), style: TextStyles.regular14White),
                Text('Osama Gabr', style: TextStyles.bold24White),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(AssetsManager.iconTheme),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,

                  child: Text('EN', style: TextStyles.bold20Primary),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 110,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AssetsManager.iconMap, width: 24, height: 24),
                    SizedBox(width: 8),
                    Text('Cairo, Egypt', style: TextStyles.bold14White),
                  ],
                ),
                SizedBox(height: 8),
                Expanded(
                  child: DefaultTabController(
                    length: eventsName.length,
                    child: TabBar(
                      onTap: (index) {
                        selectedIndex = index;
                        setState(() {});
                      },
                      labelColor: ColorsManager.whiteColor,
                      labelPadding: EdgeInsets.symmetric(horizontal: 8),
                      indicatorColor: ColorsManager.transparentColor,
                      dividerColor: ColorsManager.transparentColor,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      tabs: eventsName.map((eventName) {
                        return Tab(
                          child: EventsTabsItem(
                            selectedTextStyle: Theme.of(
                              context,
                            ).textTheme.headlineSmall!,

                            unselectedTextStyle: TextStyles.medium16White,
                            selectedBackgroundColor: Theme.of(
                              context,
                            ).focusColor,
                            eventName: eventName,
                            isSelected:
                                selectedIndex == eventsName.indexOf(eventName)
                                ? true
                                : false, // Example condition
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
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
    );
  }
}
