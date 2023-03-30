import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noisewatch/pages/notification_page.dart';

void signOut() {
  FirebaseAuth.instance.signOut();
}

var myDefaultBackground = Colors.black87;

var myAppBar = AppBar(
  elevation: 0,
  backgroundColor: Colors.transparent,
  leading: Icon((Icons.settings)),
  actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],
);

var myDrawer = Drawer(
  backgroundColor: Colors.grey[900],
  child: Column(
    children: [
      SizedBox(
        height: 20,
      ),
      DrawerHeader(
          child: Icon(
        Icons.play_circle_outline,
        color: Colors.red[900],
        size: 100,
      )),
      ListTile(
        leading: Icon(
          Icons.dashboard,
          color: Colors.white,
        ),
        title: Text(
          'D A S H B O A R D',
          style: TextStyle(color: Colors.white),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.list_alt_outlined,
          color: Colors.white,
        ),
        title: Text(
          'R E C O R D S',
          style: TextStyle(color: Colors.white),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.settings,
          color: Colors.white,
        ),
        title: Text(
          'S E T T I N G S',
          style: TextStyle(color: Colors.white),
        ),
      ),
      ListTile(
        onTap: signOut,
        leading: Icon(
          Icons.logout_outlined,
          color: Colors.white,
        ),
        title: Text(
          'L O G O U T',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  ),
);
