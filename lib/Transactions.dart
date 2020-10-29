// ignore: camel_case_types



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transactions{
  int _tid;
  int _amount;
  int _inout;
  //String _datetime;
  String _title;

  Transactions(this._amount, this._inout, //this._datetime,
      this._title,[this._tid]);

  Transactions.withId(this._tid, this._amount, this._inout, //this._datetime,
      this._title);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  //String get dateTime => _datetime;

  /*set datetime(String value) {
    _datetime = value;
  }*/

  int get inout => _inout;

  set inout(int value) {
    _inout = value;
  }

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
  }

  int get tId => _tid;

  set tId(int value) {
    _tid = value;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(_tid != null)
      map['tid'] = _tid;


    map['title'] = _title;
    map['amount'] = _amount;
    map['inout'] = _inout;
    //map['datetime'] = _datetime;
    return map;
  }

  Transactions.formMapObject (Map<String, dynamic> map) {
    this._tid  = map['tid'];
    this._title = map['title'];
    this._amount = map['amount'];
    this._inout = map['inout'];
    //this._datetime = map['datetime'];
  }


}