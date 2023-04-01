import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterFacePage extends StatefulWidget {
  // final int deviceID;

  const RegisterFacePage({super.key});

  @override
  State<RegisterFacePage> createState() => _RegisterFacePageState();
}

class _RegisterFacePageState extends State<RegisterFacePage> {
  final _videoControllerKey = UniqueKey();
  bool _isControllerInitialized = false;
  String _fullName = '';

  VlcPlayerController videoController = VlcPlayerController.network(
    'http://192.168.1.19:5000/video_feed',
    hwAcc: HwAcc.full,
    autoPlay: true,
    options: VlcPlayerOptions(),
  );

  Future<void> registerFace(String fullName) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.19:5000/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'full_name': fullName}),
    );

    if (response.statusCode == 200) {
      print('Face registered successfully');
      VlcPlayerController newController = VlcPlayerController.network(
        'http://192.168.1.19:5000/video_feed',
        hwAcc: HwAcc.full,
        autoPlay: true,
        options: VlcPlayerOptions(),
      );
      newController.addListener(() {
        if (newController.value.isInitialized) {
          setState(() {
            videoController.dispose();
            videoController = newController;
          });
        }
      });
    } else {
      print('Error registering face');
    }
  }
  // String get noiseWatchURL {
  //   switch (widget.deviceID) {
  //     case 1:
  //       return 'http://192.168.1.17:5000';
  //     case 2:
  //       return 'http://192.168.1.18:5000';
  //     default:
  //       throw Exception('Invalid device ID.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(size: 50, color: Colors.white, Icons.arrow_back)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.centerLeft,
              child: Text(
                'Register a new student',
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .white, // Change this to your desired border color when not focused
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .white, // Change this to your desired focused border color
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors
                          .white, // Change this to your desired label color when not focused
                    ),
                  ),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _fullName = value;
                    });
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    labelText: 'Full Name',
                  ),
                  cursorColor:
                      Colors.white, // Change this to your desired cursor color
                  style: const TextStyle(
                    color: Colors
                        .white, // Change this to your desired input text color
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 350,
              height: 300,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 12)),
                  ],
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(30)),
              child: VlcPlayer(
                controller: videoController,
                aspectRatio: 16 / 9,
                placeholder: const Center(child: CircularProgressIndicator()),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Register face button
            Padding(
                padding: const EdgeInsets.all(30),
                child: ElevatedButton(
                  onPressed: () {
                    if (_fullName.isNotEmpty) {
                      // Call registerFace function with the entered full name
                      registerFace(_fullName);
                    } else {
                      // Display a message if the full name is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a full name.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 120)),
                  child: Text(
                    'Register Face',
                    style: TextStyle(fontSize: 15),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';

// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// Future<void> registerFace(String fullName) async {
//   final response = await http.post(
//     Uri.parse('http://your_flask_app_ip:5000/register'),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({'full_name': fullName}),
//   );

//   if (response.statusCode == 200) {
//     print('Face registered successfully');
//   } else {
//     print('Error registering face');
//   }
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   String _fullName = '';
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//         'http://your_flask_app_ip:5000/video_feed')
//       ..initialize().then((_) {
//         setState(() {});
//       });
//     _controller.setLooping(true);
//     _controller.play();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       body: Column(children: [
//         Text(
//           'Unidentified Persons',
//           style: GoogleFonts.openSans(color: Colors.white, fontSize: 26),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Webcam stream container
//             _controller.value.isInitialized
//                 ? AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: VideoPlayer(_controller),
//                   )
//                 : Container(),
//             // Full name input field
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     _fullName = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Full Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),

//             // Register face button
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_fullName.isNotEmpty) {
//                     // Call registerFace function with the entered full name
//                     registerFace(_fullName);
//                   } else {
//                     // Display a message if the full name is empty
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Please enter a full name.')),
//                     );
//                   }
//                 },
//                 child: Text('Register Face'),
//               ),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }
// }
