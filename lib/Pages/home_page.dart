import 'package:flutter/material.dart';
import 'package:mypocket/Pages/all_transaction.dart';
import 'package:mypocket/Pages/profile_page.dart';
import 'package:mypocket/Pages/add_transaction.dart';
import 'package:mypocket/main.dart';
import 'package:mypocket/Transaction.dart';

List<Transaction> list = [new Transaction(200, false, DateTime.now(),"Swiggy", "t1"), Transaction(5888, true, DateTime.now(),"S2wiggy", "t12"),];


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget buildbody(BuildContext ctxt , int index){
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        elevation: 7,
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
                    icon: Icon(Icons.info_outline),
                    onPressed: () {},

                  )


                ],
              ),

            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
              child: Row(
                children: [
                  Icon (
                    (list[index].inOut) ? Icons.arrow_upward : Icons.arrow_downward,
                    color: (list[index].inOut) ? Colors.green : Colors.red,
                  ),
                  Text(
                    "\$${list[index].amount.toString()}",
                    style: TextStyle(
                        color: (list[index].inOut)? Colors.green : Colors.red,
                        fontSize: 25
                    ),
                  ),


                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  list[index].dateTime.toString()
                )
              ],
            )

          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    Future navigatetoPage(context) async{
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransaction()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue[300],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext ctxt, int index) => buildbody(ctxt, index),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          navigatetoPage(context);
        },
          
        label: Text('+ Add Transaction'),
    ),
    );
  }
}
