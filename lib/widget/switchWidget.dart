import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plc_app/widget/baseWidget.dart';
import 'package:plc_app/widgetClass.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../demo.dart';

class SwitchWidgetBuilder extends BaseWidgetBuilder {
  late String _toggleOnID;
  late String _toggleOffID;
  late bool _value;

  SwitchWidgetBuilder({
    super.key,
    required String title,
    required String toggleOnID,
    required String toggleOffID,
    required bool value,
  }) : super(title: title) {
    _toggleOnID = toggleOnID;
    _toggleOffID = toggleOffID;
    _value = value;
  }

  @override
  State<SwitchWidgetBuilder> createState() => _SwitchWidgetBuilderState();
}

class _SwitchWidgetBuilderState extends State<SwitchWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Card(
        child: Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            widget._value
                                ? widget._toggleOnID
                                : widget._toggleOffID,
                            style: const TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 36,
                        ),
                        Switch(
                            value: widget._value,
                            onChanged: (value) {
                              setState(() {
                                widget._value = value;
                              });
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchWidgetSetting extends BaseWidgetSetting {
  const SwitchWidgetSetting({super.key});

  @override
  State<SwitchWidgetSetting> createState() => _SwitchWidgetSettingState();
}

class _SwitchWidgetSettingState extends State<SwitchWidgetSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const ImageIcon(
          AssetImage('assets/icons/icons8-switch-50.png'),
        ),
        title: const Text("Switch"),
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SwitchWidgetSettingUI()),
            )),
      ),
    );
  }
}

class SwitchWidgetSettingUI extends StatefulWidget {
  const SwitchWidgetSettingUI({super.key});

  @override
  State<SwitchWidgetSettingUI> createState() => _SwitchWidgetSettingUIState();
}

class _SwitchWidgetSettingUIState extends State<SwitchWidgetSettingUI> {
  String _title = 'Demo';
  String _toggleOnID = 'On';
  String _toggleOffID = 'Off';
  final bool _value = true;
  late SwitchWidgetBuilder _switchWidgetDisplay;
  late int _min = 0;
  late int _max = 200;
  final TextEditingController _maxValueController = TextEditingController();
  final TextEditingController _minValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _switchWidgetDisplay = SwitchWidgetBuilder(
      title: _title,
      value: _value,
      toggleOffID: _toggleOffID,
      toggleOnID: _toggleOnID,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Switch Display Builder"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            _switchWidgetDisplay,
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
                      _title = text;
                      _switchWidgetDisplay = SwitchWidgetBuilder(
                        title: _title,
                        value: _value,
                        toggleOffID: _toggleOffID,
                        toggleOnID: _toggleOnID,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20.0,
              ),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Off',
                ),
                onSubmitted: (text) {
                  setState(
                    () {
                      _toggleOffID = text;
                      _switchWidgetDisplay = SwitchWidgetBuilder(
                        title: _title,
                        value: _value,
                        toggleOffID: _toggleOffID,
                        toggleOnID: _toggleOnID,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20.0,
              ),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'On',
                ),
                onSubmitted: (text) {
                  setState(
                    () {
                      _toggleOnID = text;
                      _switchWidgetDisplay = SwitchWidgetBuilder(
                        title: _title,
                        value: _value,
                        toggleOffID: _toggleOffID,
                        toggleOnID: _toggleOnID,
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
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Add"),
                  onPressed: () {
                    ListWidgetClass widgetList = ListWidgetClass();
                    widgetList.addItem(_switchWidgetDisplay);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DemoPage()),
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
