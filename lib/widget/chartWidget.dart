import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plc_app/widget/baseWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../demo.dart';
import '../widgetClass.dart';

class CharWidgeBuilder extends BaseWidgetBuilder {
  late String _displayText;

  CharWidgeBuilder({
    Key? key,
    required String title,
    String? displayText,
  }) : super(title: title) {
    _displayText = displayText!;
  }

  @override
  State<CharWidgeBuilder> createState() => _CharWidgeBuilderState();
}

class _CharWidgeBuilderState extends State<CharWidgeBuilder> {
  final List<ChartData> chartData = [
    ChartData(2010, 35),
    ChartData(2011, 28),
    ChartData(2012, 34),
    ChartData(2013, 32),
    ChartData(2014, 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 18),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<ChartData, int>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class CharWidgeSetting extends BaseWidgetSetting {
  const CharWidgeSetting({super.key});

  @override
  State<CharWidgeSetting> createState() => _CharWidgeSettingState();
}

class _CharWidgeSettingState extends State<CharWidgeSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const ImageIcon(
          AssetImage('assets/icons/icons8-comboChart-50.png'),
        ),
        title: const Text("Chart"),
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CharWidgeSettingUI()),
            )),
      ),
    );
  }
}

class CharWidgeSettingUI extends StatefulWidget {
  const CharWidgeSettingUI({super.key});

  @override
  State<CharWidgeSettingUI> createState() => _CharWidgeSettingUIState();
}

class _CharWidgeSettingUIState extends State<CharWidgeSettingUI> {
  late CharWidgeBuilder _terminalWidgetDisplay;

  @override
  void initState() {
    super.initState();
    _terminalWidgetDisplay = CharWidgeBuilder(
      title: 'Demo',
      displayText:
          '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chart Builder"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            _terminalWidgetDisplay,
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20.0,
              ),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                onSubmitted: (text) {
                  setState(
                    () {
                      _terminalWidgetDisplay = CharWidgeBuilder(
                        title: '',
                        displayText: 'Hello',
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 8,
                ),
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text("Add"),
                  onPressed: () {
                    ListWidgetClass widgetList = ListWidgetClass();
                    widgetList.addItem(_terminalWidgetDisplay);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const DemoPage()),
                    );
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
