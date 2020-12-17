import 'package:flutter/material.dart';
import 'all_transactionTab.dart';
import 'weeklyTransactionsTab.dart';
import 'monthlyTransactionTab.dart';


class AllTransaction extends StatefulWidget {
  @override
  _AllTransactionState createState() => _AllTransactionState();
}

class _AllTransactionState extends State<AllTransaction> with SingleTickerProviderStateMixin {

  TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 1, length: 3);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title: Text("All Transactions"),
          elevation: 0.7,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[

              Tab(text: "ALL"),
              Tab(
                text: "WEEKLY",
              ),
              Tab(
                text: "MONTHLY",
              ),
            ],
          ),
          actions: <Widget>[
            Icon(Icons.search),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
            Icon(Icons.more_vert)
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            allTranactionPage(),
            WeeklyTransaction(),
            MonthlyTransaction()
          ],
        ),


      );
    }
  }

