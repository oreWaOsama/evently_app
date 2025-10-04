import 'package:evently_app/core/theming/assets_manager.dart';
import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/feature/home/taps/create_event/create_event.dart';
import 'package:evently_app/feature/home/taps/faviorte/faviorte_tab.dart';
import 'package:evently_app/feature/home/taps/home_tab/home_tab.dart';
import 'package:evently_app/feature/home/taps/map/map_tab.dart';
import 'package:evently_app/feature/home/taps/profile/profile_tab.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> tabs = [
    HomeTab(),
    const MapTab(),
    const FaviorteTab(),
    const ProfileTab(), // Assuming you have a ProfileTap widget
    // Add other tabs here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],

      bottomNavigationBar: Theme(
        data: Theme.of(
          context,
        ).copyWith(canvasColor: ColorsManager.transparentColor),
        child: BottomAppBar(
          padding: EdgeInsets.zero,
          shape: const CircularNotchedRectangle(),
          color: Theme.of(context).primaryColor,
          notchMargin: 4,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },

            items: [
              buildBottomNavigationBarItem(
                idex: 0,
                selectedIconName: AssetsManager.iconHomeSelected,
                unSelectedIconName: AssetsManager.iconHome,
                label: 'Home',
              ),
              buildBottomNavigationBarItem(
                idex: 1,
                selectedIconName: AssetsManager.iconMapSelected,
                unSelectedIconName: AssetsManager.iconMap,
                label: 'Map',
              ),
              buildBottomNavigationBarItem(
                idex: 2,
                selectedIconName: AssetsManager.iconFavoriteSelected,
                unSelectedIconName: AssetsManager.iconFavorite,
                label: 'Favorite',
              ),
              buildBottomNavigationBarItem(
                idex: 3,
                selectedIconName: AssetsManager.iconProfileSelected,
                unSelectedIconName: AssetsManager.iconProfile,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateEvent.routeName);
        },
        child: const Icon(Icons.add, size: 35, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String selectedIconName,
    required String unSelectedIconName,
    required String label,
    required int idex,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(
          selectedIndex == idex ? selectedIconName : unSelectedIconName,
        ),
      ),
      label: label,
    );
  }
}
