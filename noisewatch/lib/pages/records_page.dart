import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noisewatch/components/constants.dart';
import 'package:noisewatch/components/records_tile.dart';
import 'package:noisewatch/utils/dialog_box.dart';

import '../components/recently_recorded_tile.dart';

class RecordsPage extends StatefulWidget {
  RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  DatabaseReference records = FirebaseDatabase.instance.ref().child('Records');
  final databaseRef = FirebaseDatabase.instance.ref();

  //name controller
  final nameController = TextEditingController();
  final offenseController = TextEditingController();

  //save records
  void saveName() {
    print(nameController);
    print(offenseController);

    Map<String, dynamic> data = {
      "name": nameController.text,
      "offense": int.parse(offenseController.text)
    };

    databaseRef
        .child("Records")
        .child(nameController.text)
        .set(data)
        .then((value) {
      nameController.clear();
      offenseController.clear();
      Navigator.of(context).pop();
    });
  }

  void createNewRecord() {
    showDialog(
        context: context,
        builder: ((context) {
          return DialogBox(
            nameController: nameController,
            offenseController: offenseController,
            onSave: saveName,
            onCancel: () => Navigator.of(context).pop(),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade200,
        onPressed: createNewRecord,
        child: Icon(size: 30, color: Colors.black87, Icons.add),
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Records',
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 26),
            ),
          ),
          Divider(),

          StreamBuilder(
              stream: records.onValue,
              builder: (
                BuildContext context,
                AsyncSnapshot snapshot,
              ) {
                if (snapshot.hasError) {
                  return Text('Something went wrong...');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.red[900]),
                  );
                } else {
                  Map map = snapshot.data!.snapshot.value;
                  List list = [];
                  list.clear();
                  list = map.values.toList();

                  return Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10.0),
                            child: RecentlyRecordedTile(
                              keyName: list[index]['name'],
                              name: list[index]['name'],
                              offense: list[index]['offense'],
                            ),
                          );
                        }),
                  );
                }
              })
          // Expanded(
          //     child: ListView.builder(
          //         itemCount: 10,
          //         itemBuilder: (context, index) {
          //           return RecordsTile();
          //         }))
        ],
      ),
    );
  }
}
