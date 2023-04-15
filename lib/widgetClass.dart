import 'package:flutter/material.dart';

class ListWidgetClass {
  static List<Widget> widgetList = [];

  void addItem(Widget widget) {
    widgetList.add(widget);
  }
}