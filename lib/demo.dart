import 'package:flutter/material.dart';
import 'package:plc_app/homePage.dart';
import 'package:plc_app/widget/chartWidget.dart';
import 'package:plc_app/widget/numDisplayWidget.dart';
import 'package:plc_app/widget/numInputWidget.dart';
import 'package:plc_app/widget/switchWidget.dart';
import 'package:plc_app/widget/terminalWidget.dart';
import 'package:plc_app/widget/textInputWidget.dart';
import 'widget/gaugeWidget.dart';
import 'widget/sliderWidget.dart';
import 'widgetClass.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final bool _adminStatus = true;

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Sample App"),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
        actions: _adminStatus
            ? [
                IconButton(
                  onPressed: _openEndDrawer,
                  icon: const Icon(Icons.add),
                ),
              ]
            : [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: ListWidgetClass.widgetList,
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Widget Builder',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const GaugeWidgetSetting(),
            const SliderWidgetSetting(),
            const NumDisplayWidgetSetting(),
            const SwitchWidgetSetting(),
            const NumInputWidgetSetting(),
            const TerminalWidgetSetting(),
            const TextInputWidgeSetting(),
            const CharWidgeSetting(),
          ],
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
    );
  }
}
