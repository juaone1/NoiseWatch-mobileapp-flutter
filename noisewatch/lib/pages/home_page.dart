import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget tabletScaffold;
  final Widget desktopScaffold;

  const HomePage(
      {super.key,
      required this.mobileScaffold,
      required this.tabletScaffold,
      required this.desktopScaffold});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 500) {
        return mobileScaffold;
      } else if (constraints.maxWidth < 1100) {
        return tabletScaffold;
      } else {
        return desktopScaffold;
      }
    });
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.black87,
    //     foregroundColor: Colors.red[900],
    //     actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],
    //   ),
    //   body: Center(
    //     child: Text('LOGGED IN!'),
    //   ),
    // );
  }
}
