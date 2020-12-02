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

  final String appBarTitle;
  final Transactions transactions;


  AddTransaction( this.transactions, this.appBarTitle);

  @override
  _AddTransactionState createState() => _AddTransactionState(this.transactions, this.appBarTitle);
}

class _AddTransactionState extends State<AddTransaction> {

  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  //variable for radio button
  Transactions transaction;

  String appBarTitle;

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int  selectedButton = -1;

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
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      backgroundColor: Colors.white,

      //Body of the form

      body: SingleChildScrollView(  //To make page scrollable
        child: Form(
          key: _formKey,
          child: new Center(//Center the form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, //make form to take the whole width of screen

              children: <Widget>[

                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: TextFormField(
                    controller: titleController,
                    validator: (text){
                      print('text ' + text);
                      if(text == null || text.isEmpty){
                        return 'Title can not be empty';
                      }
                      return null;

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
                  padding: EdgeInsets.all(25),
                  child: TextFormField(

                    controller: dateController,
                    readOnly: true,

                    onTap: (){
                      _selectDate(context);
                    },

                    decoration: new InputDecoration(
                        filled: true,
                        suffixIcon: Icon(Icons.calendar_today_rounded),
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
        transaction.datetime = DateTime.parse(DateFormat('yyyy-MM-dd'). format(now));
      }


      if(selectedButton == 1)transaction.inout = 0;
      else transaction.inout = 1;

      //_showAlertDialog(transaction.title.runtimeType.toString() + transaction.amount.runtimeType.toString(), transaction.inout.runtimeType.toString());
      print("before" );
      int result = 0;
      print(transaction.tid);
      if(transaction.tid == null){
        print("null tid");
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

    List<Transactions> l = await provider.getlastDays();


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
}
