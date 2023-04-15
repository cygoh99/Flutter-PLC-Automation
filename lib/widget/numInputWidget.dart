import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plc_app/widget/baseWidget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../demo.dart';
import '../widgetClass.dart';

class NumInputWidgetBuilder extends BaseWidgetBuilder {
  late String _unit;
  late double _value;
  late int _min;
  late int _max;

  NumInputWidgetBuilder({
    super.key,
    required String title,
    required double value,
    required String unit,
    int? min,
    int? max,
  }) : super(title: title) {
    _value = value;
    _unit = unit;
    _min = min ?? 0;
    _max = max ?? 100;
  }

  @override
  State<NumInputWidgetBuilder> createState() => _NumInputWidgetBuilderState();
}

class _NumInputWidgetBuilderState extends State<NumInputWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        child: SizedBox(
          height: 125,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget._value.toString(),
                            style: const TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Text(
                            widget._unit.toString(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Wrap(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    widget._value = widget._value + 1;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    widget._value = widget._value - 1;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NumInputWidgetSetting extends BaseWidgetSetting {
  const NumInputWidgetSetting({super.key});

  @override
  State<NumInputWidgetSetting> createState() => _NumInputWidgetSettingState();
}

class _NumInputWidgetSettingState extends State<NumInputWidgetSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const ImageIcon(
          AssetImage('assets/icons/icons8-volumeLevel-67.png'),
        ),
        title: const Text("Number Input"),
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NumInputWidgetSettingUI()),
            )),
      ),
    );
  }
}

class NumInputWidgetSettingUI extends StatefulWidget {
  const NumInputWidgetSettingUI({super.key});

  @override
  State<NumInputWidgetSettingUI> createState() =>
      _NumInputWidgetSettingUIState();
}

class _NumInputWidgetSettingUIState extends State<NumInputWidgetSettingUI> {
  String _title = 'Demo';
  final double _value = 20;
  late String _unit = '%';
  late NumInputWidgetBuilder _numDisplayWidgetDisplay;
  late int _min = 0;
  late int _max = 200;
  final TextEditingController _maxValueController = TextEditingController();
  final TextEditingController _minValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _numDisplayWidgetDisplay = NumInputWidgetBuilder(
      title: _title,
      value: _value,
      unit: _unit,
      min: _min,
      max: _max,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Input Builder"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            _numDisplayWidgetDisplay,
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
                      _numDisplayWidgetDisplay = NumInputWidgetBuilder(
                        title: _title,
                        value: _value,
                        unit: _unit,
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
                  labelText: 'Unit',
                ),
                onSubmitted: (text) {
                  setState(
                    () {
                      _unit = text;
                      _numDisplayWidgetDisplay = NumInputWidgetBuilder(
                        title: _title,
                        value: _value,
                        unit: _unit,
                        min: _min,
                        max: _max,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Min Value",
                      ),
                      keyboardType: TextInputType.number,
                      controller: _minValueController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onSubmitted: (val) {
                        int? parsedValue = int.tryParse(val);
                        if (parsedValue != null) {
                          setState(() {
                            if (parsedValue < _max) {
                              _min = parsedValue;
                              _numDisplayWidgetDisplay = NumInputWidgetBuilder(
                                title: _title,
                                unit: _unit,
                                value: _value,
                                min: _min,
                                max: _max,
                              );
                            } else {
                              _minValueController.clear();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Invalid Input'),
                                    content: const Text(
                                        'Minimum value must be greater than maximum value.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Max Value",
                      ),
                      keyboardType: TextInputType.number,
                      controller: _maxValueController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onSubmitted: (val) {
                        int? parsedValue = int.tryParse(val);
                        if (parsedValue != null) {
                          setState(
                            () {
                              if (_min < parsedValue) {
                                _max = parsedValue;
                                _numDisplayWidgetDisplay =
                                    NumInputWidgetBuilder(
                                  title: _title,
                                  unit: _unit,
                                  value: _value,
                                  min: _min,
                                  max: _max,
                                );
                              } else {
                                _maxValueController.clear();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Invalid Input'),
                                      content: const Text(
                                          'Maximum value must be greater than minimum value.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
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
                    widgetList.addItem(_numDisplayWidgetDisplay);
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
