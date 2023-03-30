import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class NeumorphicTile extends StatefulWidget {
  final String deviceName;
  final int deviceID;

  const NeumorphicTile(
      {super.key, required this.deviceName, required this.deviceID});

  @override
  State<NeumorphicTile> createState() => _NeumorphicTileState();
}

class _NeumorphicTileState extends State<NeumorphicTile> {
  bool _switchValue = false;

  void _sendStreamRequest(int deviceId, bool startStream) async {
    var url;
    switch (deviceId) {
      case 1:
        url = startStream
            ? 'http://192.168.1.20:5000/stream_start'
            : 'http://192.168.1.20:5000/stream_stop';
        break;
      case 2:
        url = startStream
            ? 'http://192.168.1.20:5000/stream_start'
            : 'http://192.168.1.20:5000/stream_stop';
        break;
      default:
        print('Invalid device ID.');
        return;
    }
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Stream request sent successfully.');
    } else {
      print(
          'Failed to send stream request. Error code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 180,
        height: 180,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade900,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 14,
                offset: Offset(4, 4),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 14,
                offset: Offset(-4, -4),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Icon(
                    Icons.camera,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                Column(
                  children: [
                    Transform.rotate(
                      angle: -pi / 2,
                      child: Transform.scale(
                        scale: 0.9,
                        child: Switch(
                          value: _switchValue,
                          onChanged: (value) {
                            setState(() {
                              _switchValue = value;
                              _sendStreamRequest(widget.deviceID, _switchValue);
                            });
                          },
                          activeColor: Colors.green,
                          inactiveTrackColor: Colors.grey.shade600,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ],
            ),
            Text(
              widget.deviceName,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
