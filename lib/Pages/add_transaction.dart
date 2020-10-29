//import 'dart:html';

//import 'dart:html';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypocket/Transactions.dart';
import 'package:mypocket/main.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:mypocket/database/Database_provider.dart';

//The page where a transction gets input

class AddTransaction extends StatefulWidget {



  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  //variable for radio button

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int  selectedButton = -1;

  Transactions transaction = Transactions(100, 0, "ejn");
  DatabaseProvider provider = DatabaseProvider();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      backgroundColor: Colors.white,

      //Body of the form

      body: SingleChildScrollView(  //To make page scrollable
        child: new Center(//Center the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, //make form to take the whole width of screen

            children: <Widget>[

              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: TextFormField(
                  controller: titleController,

                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Title",

                    hintText: 'Enter Title',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                  updateTitle();
                },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: TextFormField(
                  onChanged: (value) {
                    updateAmount();
                  },
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 25
                  ),
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Amount",

                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                ),
              ),
              Container(
                padding: EdgeInsets.all(25),
                child: TextFormField(

                  onChanged: (value) {
                    //_showAlertDialog("ld", "dj");
                    updateDate();
                  },

                  decoration: new InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              //SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Radio(
                    value: 0,
                    groupValue: selectedButton,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      //transaction.inOut = true;
                      setState(() {
                        selectedButton = value;

                        //transaction.inOut = (value == 0)?false : true;
                      });
                    },
                  ),
                  Text(
                    'Income',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 40),
                  Radio(
                    value: 1,
                    activeColor: Colors.green,
                    groupValue: selectedButton,
                    onChanged: (value) {
                      setState(() {
                        selectedButton = value;

                        //transaction.inOut = (value == 0)?false : true;
                      });
                    },
                  ),
                  Text(
                      'Expense',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20,0),
                child: MaterialButton(
                  height: 58,
                  //minWidth: 340,

                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25)),
                  onPressed: () {
                    setState(() {
                      //debugPrint("Successfully saved");
                      _save();
                    });
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.lightBlue,
                ),
              ),

            ],
          ),
        ),
      ),
    );


  }

  void updateTitle() {
    transaction.title = titleController.text;
  }

  void updateAmount() {
    transaction.amount = int.parse(amountController.text);

  }

  void updateDate() {

  }

  void _save() async {
    DateTime now = DateTime. now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formatted = formatter. format(now);
    //transaction.inOut = true;
    //transaction.datetime = formatted;

    if(selectedButton == 1)transaction.inout = 0;
    else transaction.inout = 1;

    //_showAlertDialog(transaction.title.runtimeType.toString() + transaction.amount.runtimeType.toString(), transaction.inout.runtimeType.toString());
    print("before" );
    int result = 0;
    if(transaction.tId == null){
      print("null tid");
      result = await provider.InsertIntoDB(transaction);
    }

    int cp = await provider.getCount();


    print("after " + cp.toString());
    if(result!=0){
      //_showAlertDialog("success", "ine");
      Navigator.pop(context, true);
    }
    else _showAlertDialog("fail", "NO");

    //_showAlertDialog("j3j", "irhj");
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

  static String getdate() {
    DateTime now = DateTime. now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formatted = formatter. format(now);
    return formatted;
  }
}
