import 'package:flutter/material.dart';
import 'package:noisewatch/components/textfield.dart';
import 'package:noisewatch/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final nameController;
  final offenseController;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.nameController,
      required this.offenseController,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade200,
      content: Container(
        height: 200,
        width: 500,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //get name
          TextField(
            controller: nameController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87))),
          ),

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
                text: "Save",
                onPressed: onSave,
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
