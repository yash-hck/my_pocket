import 'package:flutter/material.dart';


class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue[800]
      ),

    );
  }
}
