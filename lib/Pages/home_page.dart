import 'dart:async';

//import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:mypocket/Pages/customDailog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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
  List<int> IncomegraphList = [];
  List<int> ExpenseGraphList = [];
  int count = 0;
  int lastTransactions;

  int budget;
  final databaseReference = FirebaseDatabase.instance.reference();

  ChartSeriesController chartSeriesController1, chartSeriesController2;
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
      updateBudget();
      updatemonthTransaction();
      updateListView();
      updateGraphView();
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
          updatemonthTransaction();
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

    updateBudget();
    updatemonthTransaction();
    List<amountPerDay> datam = new List<amountPerDay>();

    List<amountPerDay> datamex = new List<amountPerDay>();
    /*List<amountPerDay> datam = [
      amountPerDay(2016, 'nov', Colors.red),
      amountPerDay(2017, 'dec', Colors.yellow),
      amountPerDay(2018, 'jan', Colors.green),
    ];*/
    int i = 0;
    for(int x in IncomegraphList){
      datam.add(new amountPerDay(x,  DateFormat.MMMd().format(DateTime.now().subtract(Duration(days: i))), Colors.orange));
      i++;
    }
    i = 0;
    for(int x in ExpenseGraphList){
      datamex.add(new amountPerDay(x,  DateFormat.MMMd().format(DateTime.now().subtract(Duration(days: i))), Colors.orange));
      i++;
    }
    List<amountPerDay> reversedList = new List.from(datam.reversed);
    List<amountPerDay> reversedListex = new List.from(datamex.reversed);

    /*for(int i = 0;i <= 7;i++){
      datam.add(new amountPerDay(graph[i],  DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: i))), Colors.orange));
    }*/

    var series = [
      LineSeries(
          dataSource: reversedList,
          xValueMapper: (amountPerDay amt, _) => amt.day,
          yValueMapper: (amountPerDay amt, _) => amt.amount,
          animationDuration: 2000,
          onRendererCreated: (ChartSeriesController controller){
            chartSeriesController1 = controller;
          },
          markerSettings: MarkerSettings(
            isVisible: true,
            color: Colors.white,
            shape: DataMarkerType.circle,
            borderColor: Colors.blue,
            height: 5,
            width: 5,
            borderWidth: 4
          ),

          dataLabelSettings: DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.outside)),

      LineSeries(
          dataSource: reversedListex,
          xValueMapper: (amountPerDay amt, _) => amt.day,
          yValueMapper: (amountPerDay amt, _) => amt.amount,
          animationDuration: 4500,
          onRendererCreated: (ChartSeriesController controller){
            chartSeriesController2 = controller;
          },
          markerSettings: MarkerSettings(
              isVisible: true,
              color: Colors.white,
              shape: DataMarkerType.circle,
              borderColor: Colors.redAccent,
              height: 5,
              width: 5,
              borderWidth: 4
          ),
          dataLabelSettings: DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.outside)),



      /*id: 'Clicks',
        domainFn: (amountPerDay clickData, _) => clickData.day,
        measureFn: (amountPerDay clickData, _) => clickData.amount,
        colorFn: (amountPerDay clickData, _) => clickData.color,
        data: datam,
      ),*/
    ];




    var chart = SfCartesianChart(
      primaryXAxis: CategoryAxis(
        labelRotation: 45,
        majorGridLines: MajorGridLines(width: 0),

      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0)


      ),
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Expenses of last week'),
      //legend: Legend(isVisible: true),
      //tooltipBehavior: TooltipBehavior(enable: true),
      series: series,
      enableAxisAnimation: true,
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(0),
      child: SizedBox(
        height: 300,
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
      body: SafeArea(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Expanded(
              child: ListView.builder(
                itemCount: count < 7? count : 7,

                itemBuilder: (BuildContext ctxt, int index) {
                  if(index == 0){
                    // ignore: missing_return
                    return budget!=null? showInfoCard():requestBudgetCard();
                  }
                  if(index == 1){
                    return chartWidget;
                  }
                  if (index == 2){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Recents->',

                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey

                        ),
                      ),
                    );
                  }
                  else
                  return buildbody(ctxt, index);

                },

              ),
            )
          ],
        ),
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
    updateBudget();
    updatemonthTransaction();

    updateListView();
    updateGraphView();
    chartSeriesController1?.animate();
    chartSeriesController2?.animate();
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
      Future<List<int>> transactionListFuture = provider.getListforInGraph();
      Future<List<int>> ExpenseListFuture = provider.getListforExGraph();


      transactionListFuture.then((trList) {
        setState(() {
          this.IncomegraphList = trList;
          //this.count = graphList.length;

        });
      });

      ExpenseListFuture.then((trList) {
        setState(() {
          this.ExpenseGraphList = trList;
          //this.count = graphList.length;

        });
      });

    });
  }

  void updateBudget() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String s = preferences.getString('budget');
    if(s!=null)
    budget = int.parse(s);
  }

  showInfoCard(){


    String message = 'You are going great and with in the budget';
    int days = int.parse(DateTime.now().day.toString());
    if( lastTransactions != null && lastTransactions > (budget)*(days/30)){
      int data = (lastTransactions - (budget)*(days/30)).round();
      message = 'you are getting outside budget by $data Rs';
    }

    return GestureDetector(
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return CustomDailogBox(
                title: 'Add your Budget here',
                description: 'here we go here we go here we go' ,
                text1: 'Add',
              );
            }
        );
      },
      child: Container(

        child: Card(

          color: Colors.grey[300],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          elevation: 10,
          shadowColor: Colors.black,

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(message,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Colors.black
                    ),
                  ),
                ),

              ],
            ),
          ),

        ),
      ),
    );

  }

  Widget requestBudgetCard() {

    return GestureDetector(
      onTap: (){
        showDialog(
          context: context,
          builder: (BuildContext context){
            return CustomDailogBox(
              title: 'Add your Budget here',
              description: 'here we go here we go here we go' ,
              text1: 'Add',
            );
          }
        );
      },
      child: Container(
        child: Card(

          color: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
          ),
          elevation: 10,
          shadowColor: Colors.black,

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Enter your budget to keeep track of it',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70
                  ),
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),

        ),
      ),
    );

  }

  void updatemonthTransaction() async {
    Future<int> lastmonth = provider.getLastMonthTransaction();
    lastmonth.then((value) {
      this.lastTransactions = value;

    });
  }
}
