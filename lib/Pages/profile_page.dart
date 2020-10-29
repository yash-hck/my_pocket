import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mypocket/Transactions.dart';
import 'package:mypocket/database/Database_provider.dart';
class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override

  DatabaseProvider provider = DatabaseProvider();
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue[800]
      ),
      body: Center(
        child: Text(
            "sk"
        ),
      )

    );
  }


}
