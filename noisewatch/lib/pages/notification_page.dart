import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noisewatch/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  Stream<List<Map<String, dynamic>>> _fetchImages() async* {
    final storage = FirebaseStorage.instance;
    List<Map<String, dynamic>> imageInfoList = [];

    // List all images in the storage
    final ListResult result = await storage.ref('/unknown_faces').listAll();

    // Fetch image information
    for (var ref in result.items) {
      final imageUrl = await ref.getDownloadURL();
      final metaData = await ref.getMetadata();

      // Extract the image name without the extension
      final imageName = metaData.name.split('.').first;

      // Format the timeCreated metadata as a date string
      final dateString = DateFormat('MM-dd-yyyy')
          .format(metaData.timeCreated ?? DateTime.now());

      imageInfoList.add({
        'name': imageName,
        'date': dateString,
        'url': imageUrl,
      });
    }

    yield imageInfoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Text(
            'Unidentified Persons',
            style: GoogleFonts.openSans(color: Colors.white, fontSize: 26),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: _fetchImages(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    final imageUrls = snapshot.data;
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index]['name'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(height: 10),
                                        Image.network(
                                          snapshot.data![index]['url'],
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.red.shade900,
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black54,
                            ),
                            child: ListTile(
                              title: Text(
                                snapshot.data![index]['name'],
                                style: TextStyle(color: Colors.red.shade900),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['date'],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Error loading images: ${snapshot.error}'));
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.red.shade900,
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
