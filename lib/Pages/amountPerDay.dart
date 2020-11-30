import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class amountPerDay{
  int _amount;
  String _day;
  charts.Color color;


  amountPerDay(this._amount, this._day, Color color)
    :this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue,a: color.alpha
  );

  String get day => _day;

  set day(String value) {
    _day = value;
  }

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
  }


}