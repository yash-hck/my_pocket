import 'package:flutter/material.dart';
import 'package:mypocket/Pages/AllTabsPage.dart';
import 'package:mypocket/Pages/LoginRegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  String email;

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      backgroundColor: Colors.black,
      image: Image.asset('assets/loading.gif'),
      loaderColor: Colors.white,
      photoSize: 150,
      navigateAfterSeconds: email == null?LoginRegisterPage():AllTabs(email),
    );
  }

  @override
  void initState() {
    updatePreferences();
    WidgetsFlutterBinding.ensureInitialized();
    print('en');

  }

  void updatePreferences()  async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString('email');
    await Firebase.initializeApp();

  }
}
