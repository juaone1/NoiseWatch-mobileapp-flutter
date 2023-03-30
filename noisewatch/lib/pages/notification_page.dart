import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noisewatch/components/constants.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Notifications',
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 26),
            ),
          )
        ],
      ),
    );
  }
}
