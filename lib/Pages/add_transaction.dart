//import 'dart:html';

//import 'dart:html';

//import 'dart:html';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:mypocket/Transactions.dart';
import 'package:mypocket/main.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:mypocket/database/Database_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/services.dart';
//The page where a transction gets input

class AddTransaction extends StatefulWidget {

  final String appBarTitle;
  final Transactions transactions;


  AddTransaction( this.transactions, this.appBarTitle);

  @override
  _AddTransactionState createState() => _AddTransactionState(this.transactions, this.appBarTitle);
}

class _AddTransactionState extends State<AddTransaction> {
  int tag = 1;
  PersistentBottomSheetController _sheet_controller;
  List<String> options = [
    'News', 'Entertainment', 'Politics',
    'Automotive', 'Sports', 'Education',
    'Fashion', 'Travel', 'Food', 'Tech',
    'Science','Paid to..' + '+ Add',
  ];
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  //variable for radio button
  Transactions transaction;

  String appBarTitle;

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int  selectedButton = 0;
  int selectedMode = 0;


  final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();
  //Transactions transaction = Transactions(100, 0, "ejn","");
  DatabaseProvider provider = DatabaseProvider();


  _AddTransactionState(this.transaction, this.appBarTitle);


  @override
  void initState() {
    super.initState();
    dateController.text = 'Today';
    if(transaction.tid!= null){
      titleController.text = transaction.title;
      amountController.text = transaction.amount.toString();
      String date = DateFormat.yMMMd().format(transaction.datetime);
      dateController.text = date;

      if(transaction.inout == 0)selectedButton = 0;
      else selectedButton = 1;
    }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      backgroundColor: Colors.white,

      //Body of the form

      body: SingleChildScrollView(  //To make page scrollable
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ToggleSwitch(

                    minWidth: 90.0,
                    initialLabelIndex: 0,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey[400],
                    inactiveFgColor: Colors.black45,
                    labels: ['Income', 'Expense'],
                    icons: [Icons.person_outline, Icons.group_add_outlined],
                    activeBgColors: [Colors.greenAccent, Colors.redAccent],
                    onToggle: (index) {
                      selectedButton = index;
                    },
                  ),
                  ToggleSwitch(

                    minWidth: 90.0,
                    initialLabelIndex: 0,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    labels: ['Personal', 'Shared'],
                    icons: [Icons.person_outline, Icons.group_add_outlined],
                    activeBgColors: [Colors.greenAccent, Colors.green],
                    onToggle: (index) {
                      selectedMode = index;
                    },
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: new Center(//Center the form
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch, //make form to take the whole width of screen

                  children: <Widget>[


                    Container(
                      //margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextFormField(
                        readOnly: true,
                        controller: titleController,

                        validator: (text){
                          print('text ' + text);
                          if(text == null || text.isEmpty){
                            return 'Title can not be empty';
                          }
                          return null;

                        },

                        onTap: (){
                          titleSheet();
                        },
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Title",



                          labelStyle: TextStyle(
                            fontSize: 25
                          ),

                          hintText: 'Enter Title',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 25
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 3,
                            ),
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
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 3,
                            ),

                          ),
                        ),

                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                      child: TextFormField(

                        controller: dateController,
                        readOnly: true,

                        onTap: (){
                          _selectDate(context);
                        },

                        decoration: new InputDecoration(
                            filled: true,
                            suffixIcon: Icon(Icons.calendar_today),
                            fillColor: Colors.white,
                            labelText: "Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            )),
                      ),
                    ),
                    //SizedBox(height: 20.0),


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
          ],
        ),
      ),
    );


  }
  // Function To Update Title
  void updateTitle() {
    transaction.title = titleController.text;
  }
  // Function To Update Amount
  void updateAmount() {
    transaction.amount = int.parse(amountController.text);

  }

  void updateDate() {

  }

  void _save() async {
    DateTime now = DateTime.now();
    if(_formKey.currentState.validate()){
      if(dateController.text == 'Today'){
        transaction.datetime = DateTime.parse(DateFormat('yyyy-MM-dd'). format(now));
      }
      else{
        transaction.datetime = DateTime.parse(DateFormat('yyyy-MM-dd'). format(selectedDate));
      }

      transaction.title = titleController.text;
      if(selectedButton == 1)transaction.inout = 0;
      else transaction.inout = 1;

      //_showAlertDialog(transaction.title.runtimeType.toString() + transaction.amount.runtimeType.toString(), transaction.inout.runtimeType.toString());

      int result = 0;
      if(transaction.tid == null){

        result = await provider.InsertIntoDB(transaction);
      }
      else{
        print("Update called");
        result = await provider.updateDB(transaction);
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

  void _selectDate(BuildContext context)async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat.yMMMd().format(selectedDate);
      });
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if(day.isAfter(DateTime.now()))return false;
    return true;
  }

  void titleSheet() {
    _sheet_controller = _scaffoldstate.currentState.showBottomSheet((BuildContext context){
      return DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).canvasColor),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0)),
            child: Container(
              height: MediaQuery.of(context).size.height*0.5,
              child: ListView(
                children: [
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    child: ChipsChoice<int>.single(value: tag,
                        wrapped: true,
                        onChanged: (val){
                          int size = options.length;
                          if(val != size - 1){
                            _sheet_controller.setState(() {
                              tag = val;

                              Navigator.of(context).pop();
                            });
                            titleController.text = options[tag];
                          }
                          else{
                            _showInputDialog();
                          }

                        },
                        choiceItems: C2Choice.listFrom<int, String>(
                            source: options,
                            value: (i, v) => i,
                            label: (i, v) => v
                        )),
                  ),

                ],
              ),


            ),
        ),
      );
    });
  }

  void _showInputDialog() {
    TextEditingController cont = TextEditingController();
    Alert(
      context: context,
      title: "New Category",
      content: Column(
        children: [
          TextField(
            controller: cont,
            decoration: InputDecoration(
              icon: Icon(Icons.add_circle),
              labelText: 'Add'

            ),
          )
        ],
      ),
        buttons: [
          DialogButton(
            onPressed: () {
              setState(() {
                options.removeLast();
                options.add(cont.text);
                options.add('+Add');
                Navigator.pop(context);
              });



            },
            child: Text(
              "ADD",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]

    ).show();
  }


}
