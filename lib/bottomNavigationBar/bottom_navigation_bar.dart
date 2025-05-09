import 'package:ebon_circuit/demo_for_today.dart';
import 'package:ebon_circuit/Presentation/cart.dart';
import 'package:ebon_circuit/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class BottomNavigation {
  static int _currentPageIndex = 0;

  static bottomNavigationBar(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 20.0,
        surfaceTintColor: primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bottomMenuBarItem(
              image: "assets/bottomNavigationAssets/home.png",
              title: "Home",
              onTap: () {
                _handleItemClick(0, context);
              },
              disabled: _currentPageIndex == 0, // Disable if current page
            ),
            bottomMenuBarItem(
              image: "assets/bottomNavigationAssets/menu.png",
              title: "Menu",
              onTap: () {
                _handleItemClick(1, context);
              },
              disabled: _currentPageIndex == 1, // Disable if current page
            ),
            bottomMenuBarItem(
              image: "assets/bottomNavigationAssets/orders.png",
              title: "Orders",
              onTap: () {
                _handleItemClick(2, context);
              },
              disabled: _currentPageIndex == 2, // Disable if current page
            ),
            bottomMenuBarItem(
              image: "assets/bottomNavigationAssets/more.png",
              title: "More",
              onTap: () {
                _handleItemClick(3, context);
              },
              disabled: _currentPageIndex == 3, // Disable if current page
            ),
          ],
        ));
  }

  static bottomMenuBarItem(
      {required String image,
      required String title,
      required VoidCallback onTap,
      required bool disabled}) {
    return GestureDetector(
      onTap: disabled ? null : onTap, // Disable onTap if disabled is true
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            height: 25,
            width: 25,
          ),
          Text(
            title,
            style: TextStyle(
              color: disabled
                  ? Colors.grey
                  : primaryColor, // Adjust color based on disabled state
            ),
          ),
        ],
      ),
    );
  }

  static void _handleItemClick(int index, BuildContext context) {
    if (index != _currentPageIndex) {
      // If the clicked item is not the current page, proceed

      _currentPageIndex = index;

      // Perform the desired action for the clicked item
      switch (index) {
        case 0:
          // Handle home item click
          slideNavigationPush(const DemoForToday(), context);
          break;
        case 1:
          // Handle menu item click
          slideNavigationPush(Cart(), context);
          break;
        case 2:
          // Handle orders item click
          print("Orders clicked");
          break;
        case 3:
          // Handle more item click
          print("More clicked");
          break;
      }
    }
  }
}
