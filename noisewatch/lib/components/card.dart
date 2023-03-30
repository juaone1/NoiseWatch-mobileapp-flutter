import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCard extends StatelessWidget {
  final int count;
  final String title;
  final Color color;
  const MyCard(
      {super.key,
      required this.count,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black54.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 12)),
      ], color: color, borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: GoogleFonts.openSans(
                color: Colors.white, fontSize: 90, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
