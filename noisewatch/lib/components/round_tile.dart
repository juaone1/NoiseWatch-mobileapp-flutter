import 'package:flutter/material.dart';

class RoundTile extends StatelessWidget {
  final String imagePath;

  const RoundTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white60),
          borderRadius: BorderRadius.circular(360),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.5),
              spreadRadius: 8,
              blurRadius: 10,
              offset: Offset(0, 8),
            )
          ]),
      child: Image.asset(
        imagePath,
        height: 72,
      ),
    );
  }
}
