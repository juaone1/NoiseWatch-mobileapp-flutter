import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noisewatch/components/card.dart';
import 'package:noisewatch/components/constants.dart';
import 'package:noisewatch/components/recently_recorded_tile.dart';
import 'package:noisewatch/pages/dashboard_page.dart';
import 'package:noisewatch/pages/notification_page.dart';
import 'package:noisewatch/pages/records_page.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  int currentIndex = 0;
  final screens = [DashboardPage(), RecordsPage(), NotificationPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: myDefaultBackground,
      // drawer: myDrawer,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() => currentIndex = index),
          currentIndex: currentIndex,
          backgroundColor: myDefaultBackground,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.red[900],
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: 'Records'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notification'),
          ]),
      body: screens[currentIndex],
    );
  }
}
