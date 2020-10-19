import 'dart:async';
import 'dart:html';



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
  String DATE = 'datetime';

  DatabaseProvider._();

  static DatabaseProvider _databaseProvider = DatabaseProvider._();

  static Database _database;

  Future<Database> get database async {
    print("call");
    if (_database != null) return _database;

    _database = await createDatabase();
    return _database;
  }

  Future<List<Map<String, dynamic>>> getTransactionMapList() async{
    Database db = await this.database;

    var result = await db.query(TRANSACTION_TABLE);
    return result;
  }

  Future<int> InsertIntoDB(Transactions transaction) async {
    Database db = await this.database;

    var result = await db.insert(TRANSACTION_TABLE, transaction.toMap());

    return result;

  }

  createDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'TransactionDB'),
        onCreate: (_databaseProvider, version) async {
          print("database created");
          await _databaseProvider.execute('''
        CREATE TABLE TRANSACTION_TABLE(ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT, AMOUNT NUMBER, INOUT NUMBER, DATETIME TEXT)'''
          );
        }
    );
  }



}


