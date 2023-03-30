import 'package:flutter/material.dart';
import 'package:noisewatch/components/textfield.dart';
import 'package:noisewatch/utils/my_button.dart';

class UpdateDialog extends StatelessWidget {
  final offenseController;
  VoidCallback onUpdate;
  VoidCallback onCancel;
  UpdateDialog(
      {super.key,
      required this.offenseController,
      required this.onUpdate,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade200,
      content: Container(
        height: 150,
        width: 500,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            height: 10,
          ),
          //get offense
          TextField(
            controller: offenseController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                hintText: "No. of Offense",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87))),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //save
              MyButton(
                text: "Update",
                onPressed: onUpdate,
              ),
              SizedBox(
                width: 20,
              ),
              //cancel
              MyButton(
                text: "Cancel",
                onPressed: onCancel,
              )
            ],
          )
        ]),
      ),
    );
  }
}
