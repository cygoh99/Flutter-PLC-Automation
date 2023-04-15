import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plc_app/widget/baseWidget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../demo.dart';
import '../widgetClass.dart';

class SliderWidgetBuilder extends BaseWidgetBuilder {
  late double _min;
  late double _max;
  late double _value;
  Function(dynamic value)? onChanged;

  SliderWidgetBuilder({
    super.key,
    required String title,
    required double min,
    required double max,
    required double value,
    Function(double value)? onChanged,
  }) : super(title: title) {
    _min = min;
    _max = max;
    _value = value;
  }

  @override
  State<SliderWidgetBuilder> createState() => _SliderWidgetBuilderState();

  void setMin(double value) {
    if (value < _max) {
      _min = value;
      if (_value < _min) {
        _value = _min;
      }
    }
  }

  void setMax(double value) {
    if (value > _min) {
      _max = value;
      if (_value > _max) {
        _value = _max;
      }
    }
  }
}

class _SliderWidgetBuilderState extends State<SliderWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Card(
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SfSlider(
                min: widget._min,
                max: widget._max,
                value: widget._value,
                interval: (widget._max - widget._min) / 5,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                numberFormat: NumberFormat("#"),
                onChanged: (value) {
                  setState(() {
                    widget._value = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderWidgetSetting extends BaseWidgetSetting {
  const SliderWidgetSetting({super.key});

  @override
  State<SliderWidgetSetting> createState() => _SliderWidgetSettingState();
}

class _SliderWidgetSettingState extends State<SliderWidgetSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const ImageIcon(
          AssetImage('assets/icons/icons8-slider-50.png'),
        ),
        title: const Text("Slider"),
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SliderWidgetSettingUI()),
            )),
      ),
    );
  }
}

class SliderWidgetSettingUI extends StatefulWidget {
  const SliderWidgetSettingUI({super.key});

  @override
  State<SliderWidgetSettingUI> createState() => _SliderWidgetSettingUIState();
}

class _SliderWidgetSettingUIState extends State<SliderWidgetSettingUI> {
  late String title = "Demo";
  late double min = 0;
  late double max = 300;
  late double value = 90;
  late SliderWidgetBuilder _sliderWidgetDisplay;
  final TextEditingController _maxValueController = TextEditingController();
  final TextEditingController _minValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _sliderWidgetDisplay = SliderWidgetBuilder(
      title: title,
      min: min,
      max: max,
      value: value,
      onChanged: ((value) {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slider Builder"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            _sliderWidgetDisplay,
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
                      title = text;
                      _sliderWidgetDisplay = SliderWidgetBuilder(
                        title: title,
                        min: min,
                        max: max,
                        value: value,
                        onChanged: ((value) {}),
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
                        double? parsedValue = double.tryParse(val);
                        if (parsedValue != null) {
                          setState(() {
                            if (parsedValue < max) {
                              min = parsedValue;
                              _sliderWidgetDisplay = SliderWidgetBuilder(
                                title: title,
                                min: min,
                                max: max,
                                value: min,
                                onChanged: ((value) {}),
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
                        double? parsedValue = double.tryParse(val);
                        if (parsedValue != null) {
                          setState(
                            () {
                              if (min < parsedValue) {
                                max = parsedValue;
                                _sliderWidgetDisplay = SliderWidgetBuilder(
                                  title: title,
                                  min: min,
                                  max: max,
                                  value: min,
                                  onChanged: ((value) {}),
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
                    widgetList.addItem(_sliderWidgetDisplay);
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
