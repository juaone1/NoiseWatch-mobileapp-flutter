import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordsTile extends StatelessWidget {
  const RecordsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black54, borderRadius: BorderRadius.circular(15)),
        height: 80,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'John Virgil Lloren Garcia',
                      style: GoogleFonts.openSans(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'January 04, 2022',
                      style: GoogleFonts.openSans(
                          fontSize: 12, color: Colors.white70),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Text('Offense:',
                style: GoogleFonts.openSans(fontSize: 13, color: Colors.white)),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('3',
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
