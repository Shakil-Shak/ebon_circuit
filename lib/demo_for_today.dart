// import 'package:ebon_circuit/Presentation/aboutus.dart';
import 'package:ebon_circuit/color.dart';
import 'package:ebon_circuit/Presentation/myorders.dart';
// import 'package:ebon_circuit/Presentation/treams_and_condition.dart';
// import 'package:ebon_circuit/customWidgets/custom_text.dart';
import 'package:ebon_circuit/Presentation/home_page.dart';
import 'package:ebon_circuit/Presentation/cart.dart';
// import 'package:ebon_circuit/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

class DemoForToday extends StatefulWidget {
  const DemoForToday({super.key});

  @override
  State<DemoForToday> createState() => _DemoForTodayState();
}

class _DemoForTodayState extends State<DemoForToday> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/bs_logo.png',
              width: 200, // Your image URL
            ),
          ],
        ),
      ),
      body: <Widget>[
        const HomePage(),
        const Cart(),
        const MyOrders()
      ][currentPageIndex],

      // bottomNavigationBar: BottomNavigation.bottomNavigationBar(context),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: primaryColor,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states) {
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: primaryColor);
            }
            return IconThemeData(color: primaryColor);
          }),
        ),
        child: NavigationBar(
          shadowColor: primaryColor,
          indicatorColor: Colors.black,
          elevation: 50,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home), // Use icons or colored assets
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long),
              label: 'Orders',
            ),
          ],
        ),
      ),

      // endDrawer: Drawer(
      //   surfaceTintColor: Colors.transparent,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: const BoxDecoration(),
      //         child: Image.asset("assets/images/bs_logo.png", height: 100),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      //         child: Center(child: customTextMain("All Menus")),
      //       ),
      //       const Divider(),
      //       ListTile(
      //         title: customTextMain('About Us'),
      //         trailing: const Icon(Icons.keyboard_arrow_right_outlined),
      //         onTap: () {
      //           Navigator.pop(context);
      //           slideNavigationPush(const AboutUsPage(), context);
      //         },
      //       ),
      //       ListTile(
      //         title: customTextMain('Terms & Conditions'),
      //         trailing: const Icon(Icons.keyboard_arrow_right_outlined),
      //         onTap: () {
      //           Navigator.pop(context);
      //           slideNavigationPush(const TermsAndConditionsPage(), context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
