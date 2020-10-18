import 'package:flutter/material.dart';

class allTranactionPage extends StatefulWidget {
  @override
  _allTranactionPageState createState() => _allTranactionPageState();
}

class _allTranactionPageState extends State<allTranactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Transactions'),
        backgroundColor: Colors.blue[800],
      ),
    );
  }
}
