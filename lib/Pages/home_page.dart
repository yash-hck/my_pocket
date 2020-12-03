import 'dart:async';

//import 'dart:html';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mypocket/Pages/all_transaction.dart';
import 'package:mypocket/Pages/amountPerDay.dart';
import 'package:mypocket/Pages/profile_page.dart';
import 'package:mypocket/Pages/add_transaction.dart';
import 'package:mypocket/database/Database_provider.dart';
import 'package:mypocket/main.dart';
import 'package:mypocket/Transactions.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Transactions> list;
  List<int> graphList = [];
  int count = 0;


  DatabaseProvider provider = DatabaseProvider();

  Future navigatetoPage(Transactions transactions, String operation) async{
    print(transactions);
    bool result;
    if(operation == 'Update'){
      result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransaction(transactions, operation)));
    }
    else {
      result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransaction(transactions, operation)));
    }


    if(result == true){
      updateListView();
    }
  }



  Widget buildbody(BuildContext ctxt , int index){
    return Dismissible (
      key: UniqueKey(),
      background: Container(

        child: Card(
          color: Colors.redAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              SizedBox(width: 300),
               Icon(Icons.delete,
               size: 40,
               color: Colors.white,)
            ],
          ),
        ),

      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {

        setState(() {
          deleteT(list[index]);
          updateListView();
          updateGraphView();
        });
      },

      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                child: Row(
                  children: [

                    Text(

                      list[index].title,
                      style: TextStyle(
                        fontSize: 30
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.edit_outlined),
                      onPressed: () {
                        navigatetoPage(list[index], 'Update');
                      },

                    )


                  ],
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                child: Row(
                  children: [
                    Icon (
                      (list[index].inout == 1) ? Icons.arrow_upward : Icons.arrow_downward,
                      color: (list[index].inout == 1) ? Colors.green : Colors.red,
                    ),
                    Text(
                      "\$${list[index].amount.toString()}",
                      style: TextStyle(
                          color: (list[index].inout == 1)? Colors.green : Colors.red,
                          fontSize: 25
                      ),
                    ),


                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,3, 10, 5),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.end,


                  children: [
                    Text(
                      //list[index].datetime,
                        DateFormat.yMMMd().format(list[index].datetime),

                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    //var datam = provider.getlastDays();

    
    List<amountPerDay> datam = new List<amountPerDay>();
    /*List<amountPerDay> datam = [
      amountPerDay(2016, 'nov', Colors.red),
      amountPerDay(2017, 'dec', Colors.yellow),
      amountPerDay(2018, 'jan', Colors.green),
    ];*/
    int i = 0;
    for(int x in graphList){
      datam.add(new amountPerDay(x,  DateFormat.MMMd().format(DateTime.now().subtract(Duration(days: i))), Colors.orange));
      i++;
    }
    /*for(int i = 0;i <= 7;i++){
      datam.add(new amountPerDay(graph[i],  DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: i))), Colors.orange));
    }*/

    var series = [
      new charts.Series(
        id: 'Clicks',
        domainFn: (amountPerDay clickData, _) => clickData.day,
        measureFn: (amountPerDay clickData, _) => clickData.amount,
        colorFn: (amountPerDay clickData, _) => clickData.color,
        data: datam,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Home',

        ),
        backgroundColor: Colors.blue[300],
      ),
      body:Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: chartWidget,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Recents->',

              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey

              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: count < 5 ? count : 5,

              itemBuilder: (BuildContext ctxt, int index) => buildbody(ctxt, index),

            ),
          )
        ],
      ),



      floatingActionButton: FloatingActionButton.extended(

        onPressed: (){
          final now = DateTime.now();
          navigatetoPage(Transactions(0, 0, '', DateTime(
              now.year,
              now.month,
              now.day,
              )), 'Add Transaction');

        },
          
        label: Text('+ Add Transaction'),
    ),
    );
  }

  @override
  void initState() {
    super.initState();
    updateListView();
    updateGraphView();
  }

  void updateListView() {
    final Future<dynamic> dbfuture = provider.createDatabase();
    
    dbfuture.then((database) {
      Future<List<Transactions>> transactionListFuture = provider.getTransactionList();

      transactionListFuture.then((trList) {
        setState(() {
          this.list = trList;
          this.count = trList.length;

        });
      });

    });
  }

  void deleteT(Transactions transactions) async{

    int delete = await provider.deleteFromDB(transactions.tid);



  }

  void updateGraphView() {
    final Future<dynamic> dbfuture = provider.createDatabase();

    dbfuture.then((database) {
      Future<List<int>> transactionListFuture = provider.getListforGraph();

      transactionListFuture.then((trList) {
        setState(() {
          this.graphList = trList;
          //this.count = graphList.length;

        });
      });

    });
  }
}
