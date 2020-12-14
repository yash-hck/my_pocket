import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
class CustomDailogBox extends StatefulWidget {

  final String title, description, text1,  text2;

  const CustomDailogBox({Key key, this.title, this.description, this.text1, this.text2}) : super(key: key);

  @override
  _CustomDailogBoxState createState() => _CustomDailogBoxState();
}

class _CustomDailogBoxState extends State<CustomDailogBox> {

  SharedPreferences preferences;
  final databaseReference = FirebaseDatabase.instance.reference();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ContentBox(context),
    );
  }

  ContentBox(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              Text(this.widget.title,
              style: TextStyle(
                fontSize: 25
              ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  style: TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Budget',
                    hintStyle: TextStyle(
                      color: Colors.grey
                    ),
                    labelText: 'Budget'

                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 15,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () async {
                    preferences = await SharedPreferences.getInstance();
                    setState(() {
                      String budget = controller.text;

                      preferences.setString('budget', budget);
                      Navigator.pop(context);
                    });
                  },

                  child: Text(this.widget.text1,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent
                  ),
                  )
                )
              )

            ],
          ),
        )
      ],
    );
  }
}
