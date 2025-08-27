import 'package:evently_app/core/theming/colors_manager.dart';

import 'package:flutter/material.dart';

class EventsTabsItem extends StatelessWidget {
  final String eventName;
  final bool isSelected;
  final Color selectedBackgroundColor;
  final TextStyle selectedTextStyle;
  final TextStyle unselectedTextStyle;
  final Color? borderColor;
  const EventsTabsItem({
    super.key,

    required this.eventName,
    required this.isSelected,
    required this.selectedBackgroundColor,
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      decoration: BoxDecoration(
        color: isSelected
            ? selectedBackgroundColor
            : ColorsManager.transparentColor,
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: borderColor ?? ColorsManager.whiteColor,
          width: 1,
        ),
      ),
      child: Text(
        eventName,
        style: isSelected ? selectedTextStyle : unselectedTextStyle,
      ),
    );
  }
}
