

import 'package:flutter/material.dart';
import 'package:mypocket/Pages/home_page.dart';
import 'package:mypocket/Pages/add_transaction.dart';
import 'Pages/all_transaction.dart';
import 'Pages/profile_page.dart';
void main() {
  runApp(MaterialApp(
    home: HomePage(),
    routes: {
      '/add_transaction_page' :(context) => AddTransaction()
    },
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


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curr_press,

        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              backgroundColor: Colors.red[300],
              title: Text('Home')

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text('All Transactions'),
              backgroundColor: Colors.greenAccent[300]

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            title: Text('My Account'),

          )
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





