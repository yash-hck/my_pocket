// ignore: camel_case_types



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transaction{
  String _tId;
  int _amount;
  bool _inOut;
  DateTime _dateTime;
  String _title;

  Transaction(this._amount, this._inOut, this._dateTime,
      this._title,[this._tId]);

  Transaction.withId(this._tId, this._amount, this._inOut, this._dateTime,
      this._title);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    _dateTime = value;
  }

  bool get inOut => _inOut;

  set inOut(bool value) {
    _inOut = value;
  }

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
  }

  String get tId => _tId;

  set tId(String value) {
    _tId = value;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();

    map['tid'] = _tId;
    map['title'] = _title;
    map['amount'] = _amount;
    map['inout'] = _inOut;
    map['datetime'] = _dateTime;
    return map;
  }

  Transaction.formMapObject (Map<String, dynamic> map) {
    this._tId  = map['tid'];
    this._title = map['title'];
    this._amount = map['amount'];
    this._inOut = map['inout'];
    this._dateTime = map['datetime'];
  }


}