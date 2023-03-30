import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noisewatch/utils/update_dialog.dart';

import '../utils/dialog_box.dart';

class RecentlyRecordedTile extends StatefulWidget {
  final String name;
  final int offense;
  final String keyName;

  RecentlyRecordedTile(
      {super.key,
      required this.name,
      required this.offense,
      required this.keyName});

  @override
  State<RecentlyRecordedTile> createState() => _RecentlyRecordedTileState();
}

class _RecentlyRecordedTileState extends State<RecentlyRecordedTile> {
  final offenseController = TextEditingController();

  DatabaseReference records = FirebaseDatabase.instance.ref().child('Records');

  updateOffense() {
    Map<String, dynamic> offense = {
      'offense': int.parse(offenseController.text)
    };
    records
        .child(widget.keyName)
        .update(offense)
        .then((value) => Navigator.of(context).pop());
  }

  getColor(no_of_offense) {
    if (no_of_offense <= 0) {
      return Colors.green;
    } else if (no_of_offense <= 2) {
      return Colors.orange.shade400;
    } else {
      return Colors.red.shade900;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: ScrollMotion(), children: [
        SlidableAction(
          onPressed: ((context) {
            //delete
            records.child(widget.keyName).remove();
          }),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
          backgroundColor: Colors.red,
          icon: Icons.delete,
        ),
        SlidableAction(
          onPressed: ((context) {
            //edit
            showDialog(
                context: context,
                builder: ((context) {
                  return UpdateDialog(
                    onUpdate: updateOffense,
                    offenseController: offenseController,
                    onCancel: () => Navigator.of(context).pop(),
                  );
                }));
          }),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange.shade600,
          icon: Icons.edit,
        )
      ]),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black54, borderRadius: BorderRadius.circular(15)),
        height: 80,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  widget.name,
                  style:
                      GoogleFonts.openSans(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text('Offense:',
                        style: GoogleFonts.openSans(
                            fontSize: 12, color: Colors.white)),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: getColor(widget.offense),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.offense.toString(),
                            style: GoogleFonts.openSans(
                                fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
