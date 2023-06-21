import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelgo/services/user_service.dart';
import 'package:travelgo/shared/theme.dart';
import 'package:travelgo/ui/pages/user/history_page.dart';
import 'package:travelgo/ui/pages/user/profile_page.dart';
import 'package:travelgo/ui/pages/user/user_home_page.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  List<Widget> pages = <Widget>[
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget myBottomNavigation() {
    return BottomNavigationBar(
      elevation: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Iconsax.task_square), label: "History"),
        BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Profile"),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: warnaCoklat,
      onTap: _onItemTapped,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: warnaAbu.withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: myBottomNavigation(),
    );
  }
}
