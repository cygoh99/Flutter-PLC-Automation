import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plc_app/widget/baseWidget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../demo.dart';
import '../widgetClass.dart';

class NumDisplayWidgetBuilder extends BaseWidgetBuilder {
  late String _unit;
  late double _value;
  late int _min;
  late int _max;

  NumDisplayWidgetBuilder({
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
  State<NumDisplayWidgetBuilder> createState() =>
      _NumDisplayWidgetBuilderState();
}

class _NumDisplayWidgetBuilderState extends State<NumDisplayWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              StepProgressIndicator(
                totalSteps: widget._max - widget._min,
                currentStep: ((widget._max - widget._min) - widget._value)
                    .round()
                    .clamp(widget._min, widget._max),
                direction: Axis.vertical,
                padding: 0,
                selectedColor: Colors.blue.shade100,
                unselectedColor: Colors.blue,
                size: 10,
              ),
              Container(
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
                    Row(
                      children: [
                        Text(
                          widget._value.toString(),
                          style: const TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(
                          width: 18,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumDisplayWidgetSetting extends BaseWidgetSetting {
  const NumDisplayWidgetSetting({super.key});

  @override
  State<NumDisplayWidgetSetting> createState() =>
      _NumDisplayWidgetSettingState();
}

class _NumDisplayWidgetSettingState extends State<NumDisplayWidgetSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const ImageIcon(
          AssetImage('assets/icons/icons8-number-50.png'),
        ),
        title: const Text("Number Display"),
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NumWidgetSettingUI()),
            )),
      ),
    );
  }
}

class NumWidgetSettingUI extends StatefulWidget {
  const NumWidgetSettingUI({super.key});

  @override
  State<NumWidgetSettingUI> createState() => _NumWidgetSettingUIState();
}

class _NumWidgetSettingUIState extends State<NumWidgetSettingUI> {
  String _title = 'Demo';
  final double _value = 20;
  late String _unit = '%';
  late NumDisplayWidgetBuilder _numDisplayWidgetDisplay;
  late int _min = 0;
  late int _max = 200;
  final TextEditingController _maxValueController = TextEditingController();
  final TextEditingController _minValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _numDisplayWidgetDisplay = NumDisplayWidgetBuilder(
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
        title: const Text("Value Display Builder"),
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
                      _numDisplayWidgetDisplay = NumDisplayWidgetBuilder(
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
                      _numDisplayWidgetDisplay = NumDisplayWidgetBuilder(
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
                              _numDisplayWidgetDisplay =
                                  NumDisplayWidgetBuilder(
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
                                    NumDisplayWidgetBuilder(
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
