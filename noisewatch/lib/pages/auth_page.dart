import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noisewatch/pages/home_page.dart';
import 'package:noisewatch/pages/login_or_register_page.dart';
import 'package:noisewatch/pages/login_page.dart';
import 'package:noisewatch/responsive%20layouts/desktop_scaffold.dart';
import 'package:noisewatch/responsive%20layouts/mobile_scaffold.dart';
import 'package:noisewatch/responsive%20layouts/tablet_scaffold.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage(
                mobileScaffold: MobileScaffold(),
                tabletScaffold: TabletScaffold(),
                desktopScaffold: DesktopScaffold(),
              );
            } else {
              return LoginOrRegisterPage();
            }
          }),
    );
  }
}
