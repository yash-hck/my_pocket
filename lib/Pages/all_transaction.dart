
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mypocket/database/Database_provider.dart';

import '../Transactions.dart';
import 'add_transaction.dart';

class allTranactionPage extends StatefulWidget {
  @override
  _allTranactionPageState createState() => _allTranactionPageState();
}

class _allTranactionPageState extends State<allTranactionPage> {

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


  @override
  Widget buildbody(BuildContext ctxt , int index){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransaction(list[index], 'update')));
      },
      child: Dismissible (
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
                            DateFormat.yMMMd().format(list[index].datetime)

                        )
                      ],
                    ),
                  )

                ],
              ),
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
        title: Center(child: Text('All Transaction')),
        backgroundColor: Colors.blue[400],
      ),
      body: ListView.builder(
        itemCount: count,

        itemBuilder: (BuildContext ctxt, int index) => buildbody(ctxt, index),


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

