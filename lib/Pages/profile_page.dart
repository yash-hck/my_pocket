import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypocket/Pages/LoginRegisterPage.dart';
import 'package:mypocket/Transactions.dart';
import 'package:mypocket/database/Database_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class profile extends StatefulWidget {

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {

  DatabaseProvider provider = DatabaseProvider();
  @override




  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue[800]
      ),
      body : Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/icon.jpg'),
                radius: 50,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('User',

                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey
                ),),
              ],
            ),
            SizedBox(height: 15,),
            Text(
              'Overall Data',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey
              ),
            ),
            SizedBox(height: 20,),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      FutureBuilder(
                      future: provider.getAllIncome(),
                      builder: (BuildContext context, AsyncSnapshot<int> text) {
                        return new Text(
                          text.data.toString(),
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.green
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          'INCOME',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.greenAccent
                          ),
                        ),
                      )

                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: provider.getAllExpense(),
                          builder: (BuildContext context, AsyncSnapshot<int> text) {
                            return new Text(
                              text.data.toString(),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.red
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          'EXPENSE',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.redAccent
                          ),
                        ),
                      )

                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: provider.getTotal(),
                          builder: (BuildContext context, AsyncSnapshot<int> text) {
                            return new Text(
                              text.data.toString(),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black45
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(

                          'TOTAL',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black45
                          ),
                        ),
                      )

                    ],
                  ),
                )
              ],
            ),



            Padding(
              child: Container(
                width: MediaQuery.of(context).size.width*0.80,
                child: RaisedButton(
                  highlightElevation: 0.0,
                  splashColor: Colors.blueAccent,
                  highlightColor: Colors.blueAccent[300],
                  elevation: 0.0,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Text(
                    'LOG OUT',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    preferences.setString('email', null);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginRegisterPage()));

                  },
                ),
                height: 50,
              ),
              padding: EdgeInsets.only(top: 80, left: 20, right: 20),
            ),


          ],
        ),
      )

    );
  }


}
