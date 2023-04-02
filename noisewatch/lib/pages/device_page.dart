import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noisewatch/components/constants.dart';
import 'package:noisewatch/pages/register_face_page.dart';

class DevicePage extends StatefulWidget {
  final int deviceID;

  const DevicePage({super.key, required this.deviceID});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  late String noiseWatchURL;
  late VlcPlayerController videoController;

  @override
  void initState() {
    super.initState();
    switch (widget.deviceID) {
      case 1:
        noiseWatchURL = 'http://192.168.1.31:5000/video_feed';
        break;
      case 2:
        noiseWatchURL = 'http://192.168.1.18:5000/video_feed';
        break;
      default:
        throw Exception('Invalid device ID.');
    }
    videoController = VlcPlayerController.network(
      noiseWatchURL,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  // final VlcPlayerController videoController = VlcPlayerController.network(
  //     'http://192.168.1.20:5000/video_feed',
  //     hwAcc: HwAcc.full,
  //     autoPlay: true,
  //     options: VlcPlayerOptions());

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
        ],
      ),
    );
  }
}
