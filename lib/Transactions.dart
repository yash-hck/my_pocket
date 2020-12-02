// ignore: camel_case_types


import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transactions{
  int _tid;
  int _amount;
  int _inout;
  DateTime _datetime;
  String _title;

  Transactions(this._amount, this._inout, //this._datetime,
      this._title,this._datetime);

  Transactions.withId(this._tid, this._amount,this._datetime, this._inout, //this._datetime,
      this._title);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  DateTime get datetime => _datetime;

  set datetime(DateTime value) {
    _datetime = value;
  }

  int get inout => _inout;

  set inout(int value) {
    _inout = value;
  }

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
  }

  int get tid => _tid;

  set tid(int value) {
    _tid = value;
  }

  Map<String, dynamic> toMap() => {
    "tid": tid,
    "title": title,
    "datetime": datetime.toIso8601String(),
    "inout": inout,
    "amount": amount,
  };

  Transactions.fromMapObject (Map<String, dynamic> map) {
    this._tid  = map['tid'];
    this._title = map['title'];
    this._amount = map['amount'];
    this._inout = map['inout'];

    this._datetime = DateTime.parse(map['datetime']);
    print('p '+ this.datetime.toString());
  }
  /*Transactions.fromMapObject(Map<String, dynamic> json) => Transactions(
    tid: json["tid"],
    title: json["title"],
    datetime: DateTime.parse(json["datetime"]),
    inout: json["inout"],
    amount: json["amount"],
  );*/


}