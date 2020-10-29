import 'dart:async';
//import 'dart:html';



import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:mypocket/Transactions.dart';

class DatabaseProvider {

  String TRANSACTION_TABLE = 'transaction_table';
  String ID = 'tid';
  String TITLE = 'title';
  String AMOUNT = 'amount';
  String INOUT = 'inout';
  //String DATE = 'datetime';

  DatabaseProvider._();

  static DatabaseProvider _databaseProvider;

  static Database _database;

  factory DatabaseProvider(){
    if(_databaseProvider == null)_databaseProvider = DatabaseProvider._();

    return _databaseProvider;
  }

  Future<Database> get database async {
    print("call");
    if (_database != null) return _database;

    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'TransactionDB'),version: 1,
        onCreate: (_databaseProvider, version) async {
          print("database created");
          await _databaseProvider.execute('CREATE TABLE $TRANSACTION_TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TITLE TEXT,  $AMOUNT NUMBER, $INOUT NUMBER)');
        }
    );
  }

  //Function to get List of all data as list of maps

  Future<List<Map<String, dynamic>>> getTransactionMapList() async{
    Database db = await this.database;

    var result = await db.query(TRANSACTION_TABLE);
    return result;
  }

  //Insert Operation

  Future<int> InsertIntoDB(Transactions transaction) async {
    Database db = await this.database;
    print(transaction.tId);
    //db.insert(TRANSACTION_TABLE, tf.toMap());
    var result = await db.insert(TRANSACTION_TABLE, transaction.toMap());

    return result;

  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $TRANSACTION_TABLE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //Update Operation

  Future<int> updateDB(Transactions transaction) async {
    Database db = await this.database;

    var result = await db.update(TRANSACTION_TABLE, transaction.toMap(), where: '$ID', whereArgs: [transaction.tId]);

    return result;
  }

  //Delete Operation

  Future<int> deleteFromDB(int id) async {
    Database db = await this.database;

    var result = await db.rawDelete('DELETE FROM $TRANSACTION_TABLE WHERE $ID = $id');

    return result;
  }

  //Database Creation Function





}


