import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypocket/main.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int  selectedButton = -1;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: new Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: TextFormField(

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
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: TextFormField(
                  
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
                      setState(() {
                        selectedButton = value;
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
                  onPressed: () {},
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
}
