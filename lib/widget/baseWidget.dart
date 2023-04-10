import 'package:flutter/material.dart';

abstract class BaseWidgetBuilder extends StatefulWidget {
  String title;

  BaseWidgetBuilder({super.key, required this.title});

  @override
  State<BaseWidgetBuilder> createState() => _BaseWidgetBuildertState();
}

class _BaseWidgetBuildertState extends State<BaseWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> buildSetting(BuildContext context) async {
    return showDialog<void>(
        builder: (BuildContext context) {
          return Container();
        },
        context: context);
  }
}

abstract class BaseWidgetSetting extends StatefulWidget {
  const BaseWidgetSetting({super.key});

  @override
  State<BaseWidgetSetting> createState() => _BaseWidgetSettingState();
}

class _BaseWidgetSettingState extends State<BaseWidgetSetting> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}