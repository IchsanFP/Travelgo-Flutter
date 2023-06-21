import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelgo/ui/pages/vendor/vendor_profile_page.dart';
import 'package:travelgo/ui/pages/vendor/paket_travel_page.dart';

import '../../../shared/theme.dart';

class VendorMainPage extends StatefulWidget {
  const VendorMainPage({super.key});

  @override
  State<VendorMainPage> createState() => _VendorMainPageState();
}

class _VendorMainPageState extends State<VendorMainPage> {
  List<Widget> pages = <Widget>[
    PaketTravelPage(),
    VendorProfilePage()
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
        BottomNavigationBarItem(icon: Icon(Iconsax.folder), label: "Paket"),
        BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Gallery"),
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