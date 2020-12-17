

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypocket/Pages/AllTabsPage.dart';
import 'package:mypocket/Pages/LoginRegisterPage.dart';
import 'package:mypocket/Pages/home_page.dart';
import 'package:mypocket/Pages/add_transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/all_transaction.dart';
import 'Pages/profile_page.dart';
import 'Pages/SplashScreen.dart';
void main() async{

  print("app start");


  print ('ndj');

  //var email = 'e';

  runApp(MaterialApp(

    home: splashScreen()

  ));
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override



  Widget build(BuildContext context) {
    return Scaffold();
  }
}





