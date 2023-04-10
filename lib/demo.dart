import 'package:flutter/material.dart';
import 'package:plc_app/widget/gaugeWidget.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final bool _adminStatus = true;
  GaugeWidgetBuilder myGaugeWidget =
      GaugeWidgetBuilder("Demo Gauge", 100, 0, 150, 0, 50, 50, 100, 100, 150);

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Sample App"),
        actions: _adminStatus
            ? [
                IconButton(
                  onPressed: _openEndDrawer,
                  icon: const Icon(Icons.add),
                ),
              ]
            : [],
      ),
      body: myGaugeWidget,
      endDrawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Add Widget'),
            ),
            GaugeWidgetSetting(),
          ],
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
    );
  }
}
