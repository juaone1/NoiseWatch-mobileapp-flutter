import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noisewatch/components/constants.dart';

class DevicePage extends StatefulWidget {
  // final int deviceID;

  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
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

  final VlcPlayerController videoController = VlcPlayerController.network(
      'http://192.168.1.20:5000/video_feed',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
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
              'NoiseWatch',
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 26),
            ),
          ),
          const SizedBox(
            height: 20,
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
          const SizedBox(
            height: 50,
          ),

          //train button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(w, h * .08),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
                onPressed: () {},
                child: Text("TRAIN")),
          ),

          const SizedBox(
            height: 20,
          ),
          //register button

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(w, h * .08),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
                onPressed: () {},
                child: Text("REGISTER")),
          ),
        ],
      ),
    );
  }
}
