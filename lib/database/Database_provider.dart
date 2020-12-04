

//import 'dart:html';


import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


import 'package:mypocket/Transactions.dart';

class DatabaseProvider {

  String TRANSACTION_TABLE = 'transaction_table';
  String ID = 'tid';
  String TITLE = 'title';
  String AMOUNT = 'amount';
  String INOUT = 'inout';
  String DATE = 'datetime';

  DatabaseProvider._();

  static DatabaseProvider _databaseProvider;

  static Database _database;

  factory DatabaseProvider(){
    if (_databaseProvider == null) _databaseProvider = DatabaseProvider._();

    return _databaseProvider;
  }

  Future<Database> get database async {
    //print("call");
    if (_database != null) return _database;

    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'TransactionDB'), version: 1,
        onCreate: (_databaseProvider, version) async {
          print("database created");
          await _databaseProvider.execute(
              'CREATE TABLE $TRANSACTION_TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TITLE TEXT,  $AMOUNT NUMBER, $INOUT NUMBER, $DATE DATETIME)');
        }
    );
  }

  //Function to get List of all data as list of maps

  Future<List<Map<String, dynamic>>> getTransactionMapList() async {
    Database db = await this.database;

    var result = await db.query(TRANSACTION_TABLE);
    return result;
  }

  //Insert Operation

  Future<int> InsertIntoDB(Transactions transaction) async {
    Database db = await this.database;
    print(transaction.tid);
    //db.insert(TRANSACTION_TABLE, tf.toMap());
    var result = await db.insert(TRANSACTION_TABLE, transaction.toMap());

    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery(
        'SELECT COUNT (*) from $TRANSACTION_TABLE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //Update Operation

  Future<int> updateDB(Transactions transaction) async {
    print("got database");
    Database db = await this.database;
    print("got database");
    Map<String , dynamic> mp = transaction.toMap();
    print(mp.length);
    var result = await db.update(
        TRANSACTION_TABLE, transaction.toMap(), where: '$ID = ?',
        whereArgs: [transaction.tid]);
    print("got result" + result.toString());
    return result;
  }

  //Delete Operation

  Future<int> deleteFromDB(int id) async {
    Database db = await this.database;

    var result = await db.rawDelete(
        'DELETE FROM $TRANSACTION_TABLE WHERE $ID = $id');

    return result;
  }

  Future<List<Transactions>> getTransactionList() async {
    var TtransactionMapList = await getTransactionMapList();
    int cnt = TtransactionMapList.length;

    List<Transactions> list = List<Transactions>();

    for(int i = cnt - 1;i>=0;i--){
      list.add(Transactions.fromMapObject(TtransactionMapList[i]));
    }

    return list;

  }

  Future<int> getAllIncome() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT SUM($AMOUNT) FROM $TRANSACTION_TABLE WHERE $INOUT = 1');

    return result[0]['SUM(amount)'];

  }

  //Function to get all Expanse

  Future<int> getAllExpense() async {
    Database db = await this.database;


    var result = await db.rawQuery('SELECT SUM($AMOUNT) FROM $TRANSACTION_TABLE WHERE $INOUT = 0');

    return result[0]['SUM(amount)'];

  }

//Function To get Final amount
  Future<int> getTotal() async {

    var income = await getAllIncome();
    var expense = await getAllExpense();

    return income - expense;

  }

  Future<List<Transactions>> getlastDays() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM $TRANSACTION_TABLE WHERE $DATE > date('now','-7 days')");
    int cnt = result.length;
    print(result.runtimeType);
    List<Transactions> list = List<Transactions>();

    for(int i = cnt - 1;i>=0;i--){
      list.add(Transactions.fromMapObject(result[i]));
    }
    print('here' + cnt.toString());
    return list;

  }

  Future<List<int>> getListforInGraph()async{

    Database db = await this.database;

    List<int> list = new List<int>();
    var prevans = await db.rawQuery("SELECT SUM($AMOUNT) FROM $TRANSACTION_TABLE WHERE $DATE > date('now','0 days') AND $INOUT = 1");
    list.add(prevans[0]['SUM(amount)']);
    for(int i = -1; i > -7;i--){
      var result = await db.rawQuery("SELECT SUM($AMOUNT) FROM $TRANSACTION_TABLE WHERE $DATE > date('now','$i days') AND $INOUT = 1");
      list.add((result[0]['SUM(amount)']==null ? 0:  result[0]['SUM(amount)']) - (prevans[0]['SUM(amount)'] == null ? 0 :prevans[0]['SUM(amount)']));
      //print('for ' + i.toString() + ' amount -> ' + (result[0]['SUM(amount)']-prevans[0]['SUM(amount)']).toString());
      prevans = result;
    }
    return list;


  }
  Future<List<int>> getListforExGraph()async{

    Database db = await this.database;

    List<int> list = new List<int>();
    var prevans = await db.rawQuery("SELECT SUM($AMOUNT) FROM $TRANSACTION_TABLE WHERE $DATE > date('now','0 days') AND $INOUT = 0");
    list.add(prevans[0]['SUM(amount)']);
    for(int i = -1; i > -7;i--){
      var result = await db.rawQuery("SELECT SUM($AMOUNT) FROM $TRANSACTION_TABLE WHERE $DATE > date('now','$i days') AND $INOUT = 0");
      list.add((result[0]['SUM(amount)']==null ? 0:  result[0]['SUM(amount)']) - (prevans[0]['SUM(amount)'] == null ? 0 :prevans[0]['SUM(amount)']));
      //print('for ' + i.toString() + ' amount -> ' + (result[0]['SUM(amount)']-prevans[0]['SUM(amount)']).toString());
      prevans = result;
    }
    return list;


  }

}


