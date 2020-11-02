

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mypocket/Pages/profile_page.dart';

import 'all_transaction.dart';
import 'home_page.dart';

class AllTabs extends StatefulWidget {

  final String NAME;


  AllTabs(this.NAME);

  @override
  _AllTabsState createState() => _AllTabsState(this.NAME);
}

class _AllTabsState extends State<AllTabs> {

  String NAME;

  _AllTabsState(this.NAME);


  int curr_press = 0;

  PageController _pageController = PageController();
  List<Widget> _screen = [Home(), allTranactionPage(), profile()];

  void _onPageChanged(int index){

  }



  @override
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

        animationDuration: Duration(milliseconds: 500),
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
