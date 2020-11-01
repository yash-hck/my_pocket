

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mypocket/Pages/AllTabsPage.dart';
import 'package:mypocket/Pages/LoginRegisterPage.dart';
import 'package:mypocket/Pages/home_page.dart';
import 'package:mypocket/Pages/add_transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/all_transaction.dart';
import 'Pages/profile_page.dart';
void main() async{
  print("app start");
  WidgetsFlutterBinding.ensureInitialized();
  print('en');
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print ('ndj');
  var email = preferences.getString('email');
  //var email = 'e';
  print(email);
  runApp(MaterialApp(

    home: email == null ? LoginRegisterPage() : AllTabs()

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





