import 'dart:async';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mypocket/Pages/all_transaction.dart';
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
                      list[index].dateTime,

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



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue[300],
      ),
      body: ListView.builder(
        itemCount: count,

        itemBuilder: (BuildContext ctxt, int index) => buildbody(ctxt, index),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          navigatetoPage(Transactions(0, 0, '', ''), 'Add Transaction');

        },
          
        label: Text('+ Add Transaction'),
    ),
    );
  }

  @override
  void initState() {
    super.initState();
    updateListView();
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
}
