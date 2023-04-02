import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noisewatch/components/neumorphic_tile.dart';
import 'package:noisewatch/model/student_record.dart';
import 'package:noisewatch/pages/device_page.dart';
import 'package:noisewatch/pages/register_face_page.dart';
import 'package:noisewatch/services/records_database_service.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/card.dart';
import '../components/recently_recorded_tile.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // final Stream<QuerySnapshot> recentlyRecorded = FirebaseFirestore.instance
  late Query records;
  List<StudentRecord> registered = [];

  int registerNum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    records = FirebaseDatabase.instance
        .ref()
        .child('Records')
        .orderByChild('offense')
        .startAt(3)
        .limitToFirst(5);
    setupRecords();
  }

  setupRecords() async {
    List<StudentRecord> studentRecords =
        await RecordsDatabaseService().getRecords();
    setState(() {
      registered = studentRecords.toList();
      registerNum = studentRecords.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //hello admin!
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Hello',
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Text(
              'admin !',
              style: GoogleFonts.montserrat(
                  color: Colors.red[900],
                  fontSize: 40,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
      //date
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      //horizontal listview

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Container(
          height: 250,
          child: ListView(
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              children: [
                MyCard(
                  count: registerNum,
                  title: 'Registered Students',
                  color: Colors.red.shade900,
                ),
                SizedBox(
                  width: 20,
                ),
                MyCard(
                  count: 10,
                  title: 'Recorded Students',
                  color: Colors.orange.shade600,
                ),
                SizedBox(
                  width: 20,
                ),
                MyCard(
                  count: 8,
                  title: 'Recorded Unknown',
                  color: Colors.pink.shade600,
                ),
              ]),
        ),
      ),

      // AspectRatio(
      //   aspectRatio: 1,
      //   child: SizedBox(
      //     width: double.infinity,
      //     child: GridView.builder(
      //         physics: NeverScrollableScrollPhysics(),
      //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 2),
      //         itemBuilder: (context, index) {
      //           return Padding(
      //             padding: const EdgeInsets.all(15),
      //             child: Container(
      //               color: Colors.black54,
      //             ),
      //           );
      //         }),
      //   ),
      // ),
      // SizedBox(
      //   height: 10,
      // ),
      //devices

      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Actions',
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      SizedBox(height: 15), // Add some spacing between the row and the buttons
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              // Handle register action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterFacePage()),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40)),
            icon: Icon(Icons.person_add_alt_1),
            label: Text('REGISTER'),
          ),

          //TRAIN
          ElevatedButton.icon(
            onPressed: () async {
              // Show loading dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.grey.shade900,
                    content: SizedBox(
                      height: 80,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.red.shade900,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Training model...',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );

              try {
                final response = await http.post(
                  Uri.parse('http://192.168.1.19:5000/train'),
                  headers: {'Content-Type': 'application/json'},
                );

                if (response.statusCode == 200) {
                  // Show success dialog
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });

                      return AlertDialog(
                        backgroundColor: Colors.grey.shade900,
                        content: Row(
                          children: [
                            Icon(Icons.check, color: Colors.green),
                            SizedBox(width: 20),
                            Text("Training complete"),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  // Show error message
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.red,
                        content:
                            Text('Error training face recognition model.')),
                  );
                }
              } catch (e) {
                // Show error message
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Error training face recognition model exception.')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black54,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            ),
            icon: Icon(Icons.school),
            label: Text('TRAIN'),
          ),
        ],
      ),
      SizedBox(height: 15),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Devices',
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),

      SizedBox(
        height: 10,
      ),
      //device tiles
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: NeumorphicTile(
                deviceID: 1,
                deviceName: "NOISEWATCH 1",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DevicePage(
                              deviceID: 1,
                            )));
              },
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: NeumorphicTile(deviceID: 2, deviceName: "NOISEWATCH 2"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DevicePage(
                              deviceID: 2,
                            )));
              },
            )
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),

      //top offenders
      // Row(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 25.0),
      //       child: Text(
      //         'Top Offenders',
      //         style: GoogleFonts.openSans(
      //             color: Colors.white,
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold),
      //       ),
      //     ),
      //   ],
      // ),
      // SizedBox(
      //   height: 10,
      // ),

      //listview

      // StreamBuilder(
      //     stream: records.onValue,
      //     builder: (
      //       context,
      //       AsyncSnapshot snapshot,
      //     ) {
      //       if (snapshot.hasError) {
      //         return Text('Something went wrong...');
      //       }
      //       if (!snapshot.hasData) {
      //         return Center(
      //           child: CircularProgressIndicator(color: Colors.red[900]),
      //         );
      //       }
      //       // if (snapshot.connectionState == ConnectionState.waiting) {
      //       //   return Center(
      //       //     child: CircularProgressIndicator(color: Colors.red[900]),
      //       //   );
      //       // }
      //       else {
      //         Map map = snapshot.data!.snapshot.value;
      //         List list = [];
      //         list.clear();
      //         list = map.values.toList();

      //         return Expanded(
      //           child: ListView.builder(
      //               itemCount: list.length,
      //               itemBuilder: (context, index) {
      //                 // return Slidable(
      //                 //   endActionPane: ActionPane(
      //                 //       extentRatio: 0.5,
      //                 //       motion: StretchMotion(),
      //                 //       children: [
      //                 //         SlidableAction(
      //                 //           borderRadius: BorderRadius.circular(20),
      //                 //           onPressed: ((context) {
      //                 //             //delete
      //                 //           }),
      //                 //           backgroundColor: Colors.red,
      //                 //           icon: Icons.delete,
      //                 //         ),
      //                 //         SizedBox(
      //                 //           width: 10,
      //                 //         ),
      //                 //         SlidableAction(
      //                 //           borderRadius: BorderRadius.circular(20),
      //                 //           onPressed: ((context) {
      //                 //             //edit
      //                 //           }),
      //                 //           foregroundColor: Colors.white,
      //                 //           backgroundColor: Colors.orange.shade600,
      //                 //           icon: Icons.edit,
      //                 //         )
      //                 //       ]),
      //                 //   child:
      //                 return Padding(
      //                   padding: const EdgeInsets.symmetric(
      //                       horizontal: 15, vertical: 10.0),
      //                   child: RecentlyRecordedTile(
      //                     keyName: list[index]['name'],
      //                     name: list[index]['name'],
      //                     offense: list[index]['offense'],
      //                   ),
      //                 );
      //                 // );
      //               }),
      //         );
      //       }
      //       // final data = snapshot.requireData;

      //       // Expanded(
      //       //     child: ListView.builder(
      //       //         itemCount: 5,
      //       //         itemBuilder: (context, index) {
      //       //           return RecentlyRecordedTile();
      //       //         }))
      //       //   ],
      //     })
    ]);
  }
}
