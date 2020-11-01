

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mypocket/Pages/home_page.dart';
import 'package:mypocket/Pages/add_transaction.dart';
import 'Pages/all_transaction.dart';
import 'Pages/profile_page.dart';
void main() {
  runApp(MaterialApp(
    home: HomePage(),

  ));
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  int curr_press = 0;

  PageController _pageController = PageController();
  List<Widget> _screen = [Home(), allTranactionPage(), profile()];

  void _onPageChanged(int index){

  }




  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),


      bottomNavigationBar: CurvedNavigationBar(
        index: curr_press,
        color: Colors.blue[400],
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.transparent,
        height: 74,

        animationDuration: Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutBack,


        items: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.home),
                    Text("Home")

                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.book),
                    Text("All")

                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.person),
                    Text("Profile")

                  ],
                ),
              ),
            ),
          ),
        ],
        onTap: (index){
          setState(() {
            _pageController.jumpToPage(index);
            curr_press = index;

          });
        },

      ),

    );
  }
}





