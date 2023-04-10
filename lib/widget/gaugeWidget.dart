import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:intl/intl.dart';
import 'package:plc_app/widget/baseWidget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class GaugeWidgetBuilder extends BaseWidgetBuilder {
  double _value;
  double _min;
  double _max;
  double _minSafeValue;
  double _maxSafeValue;
  double _minWarningValue;
  double _maxWarningValue;
  double _minDangerValue;
  double _maxDangerValue;

  GaugeWidgetBuilder(
    String title,
    this._value,
    this._min,
    this._max,
    this._minSafeValue,
    this._maxSafeValue,
    this._minWarningValue,
    this._maxWarningValue,
    this._minDangerValue,
    this._maxDangerValue,
  ) : super(title: title);

  @override
  State<GaugeWidgetBuilder> createState() => _GaugeWidgetBuilderState();

  Widget buildContent() {
    return SizedBox(
      height: 300,
      child: SfRadialGauge(
        title: GaugeTitle(
          text: title,
          textStyle:
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        axes: <RadialAxis>[
          RadialAxis(minimum: _min, maximum: _max, ranges: <GaugeRange>[
            GaugeRange(
              startValue: _minSafeValue,
              endValue: _maxSafeValue,
              color: Colors.green,
            ),
            GaugeRange(
              startValue: _minWarningValue,
              endValue: _maxWarningValue,
              color: Colors.orange,
            ),
            GaugeRange(
              startValue: _minDangerValue,
              endValue: _maxDangerValue,
              color: Colors.red,
            ),
          ], pointers: <GaugePointer>[
            NeedlePointer(
              value: _value,
            ),
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    child: Text('$_value',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
                angle: _value,
                positionFactor: 0.5)
          ]),
        ],
      ),
    );
  }
}

class _GaugeWidgetBuilderState extends State<GaugeWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.buildContent();
  }
}

class GaugeWidgetSetting extends BaseWidgetSetting {
  const GaugeWidgetSetting({super.key});

  @override
  State<GaugeWidgetSetting> createState() => _GaugeWidgetSettingState();
}

class _GaugeWidgetSettingState extends State<GaugeWidgetSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const ImageIcon(
          AssetImage('assets/icons/icons8-speed-50.png'),
        ),
        title: const Text("Gauge"),
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const GaugeWidgetSettingUI()),
            )),
      ),
    );
  }
}

class GaugeWidgetSettingUI extends StatefulWidget {
  const GaugeWidgetSettingUI({super.key});

  @override
  State<GaugeWidgetSettingUI> createState() => _GaugeWidgetSettingUIState();
}

class _GaugeWidgetSettingUIState extends State<GaugeWidgetSettingUI> {
  late String _title = "Demo";
  final double _value = 90;
  late double _min = 0;
  late double _max = 150;
  late double _minSafeValue = 0;
  late double _maxSafeValue = 50;
  late double _minWarningValue = 50;
  late double _maxWarningValue = 100;
  late double _minDangerValue = 100;
  late double _maxDangerValue = 150;
  late GaugeWidgetBuilder _gaugeWidgetDisplay;
  late FocusNode _maxValueFocusNode;
  late FocusNode _minSafeValueFocusNode;

  Widget _sliderFunction({
    required String title,
    required Color color,
    required double minValue,
    required double maxValue,
    required SfRangeValues values,
    required Function(SfRangeValues)? onChanged, //here iam getting problem
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 8.0,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SfRangeSliderTheme(
            data: SfRangeSliderThemeData(
              activeTrackColor: color,
              inactiveTrackColor: color.withOpacity(0.2),
              thumbColor: color,
            ),
            child: SfRangeSlider(
              min: minValue,
              max: maxValue,
              values: values,
              interval: (maxValue - minValue) / 5,
              showLabels: true,
              enableTooltip: true,
              numberFormat: NumberFormat("#"),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _gaugeWidgetDisplay = GaugeWidgetBuilder(
        _title,
        _value,
        _min,
        _max,
        _minSafeValue,
        _maxSafeValue,
        _minWarningValue,
        _maxWarningValue,
        _minDangerValue,
        _maxDangerValue);
    _maxValueFocusNode = FocusNode();
    _minSafeValueFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gauge Builder"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _gaugeWidgetDisplay,
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
                      _gaugeWidgetDisplay = GaugeWidgetBuilder(
                          _title,
                          _value,
                          _min,
                          _max,
                          _minSafeValue,
                          _maxSafeValue,
                          _minWarningValue,
                          _maxWarningValue,
                          _minDangerValue,
                          _maxDangerValue);
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      focusNode: _minSafeValueFocusNode,
                      onSubmitted: (value) {
                        double? parsedValue = double.tryParse(value);
                        if (parsedValue != null) {
                          setState(() {
                            _min = parsedValue;
                            _gaugeWidgetDisplay = GaugeWidgetBuilder(
                                _title,
                                _value,
                                _min,
                                _max,
                                _minSafeValue,
                                _maxSafeValue,
                                _minWarningValue,
                                _maxWarningValue,
                                _minDangerValue,
                                _maxDangerValue);
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      focusNode: _maxValueFocusNode,
                      onSubmitted: (value) {
                        double? parsedValue = double.tryParse(value);
                        if (parsedValue != null) {
                          setState(
                            () {
                              _max = parsedValue;
                              _gaugeWidgetDisplay = GaugeWidgetBuilder(
                                  _title,
                                  _value,
                                  _min,
                                  _max,
                                  _minSafeValue,
                                  _maxSafeValue,
                                  _minWarningValue,
                                  _maxWarningValue,
                                  _minDangerValue,
                                  _maxDangerValue);
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            _sliderFunction(
              title: "Safe Area Ranges",
              color: Colors.green,
              minValue: _min,
              maxValue: _minWarningValue,
              values: SfRangeValues(_minSafeValue, _maxSafeValue),
              onChanged: (values) {
                setState(
                  () {
                    _minSafeValue = values.start;
                    _maxSafeValue = values.end;
                    _gaugeWidgetDisplay = GaugeWidgetBuilder(
                        _title,
                        _value,
                        _min,
                        _max,
                        _minSafeValue,
                        _maxSafeValue,
                        _minWarningValue,
                        _maxWarningValue,
                        _minDangerValue,
                        _maxDangerValue);
                  },
                );
              },
            ),
            _sliderFunction(
              title: "Warning Area Ranges",
              color: Colors.orange,
              minValue: _maxSafeValue,
              maxValue: _minDangerValue,
              values: SfRangeValues(_minWarningValue, _maxWarningValue),
              onChanged: (values) {
                setState(
                  () {
                    _minWarningValue = values.start;
                    _maxWarningValue = values.end;
                    _gaugeWidgetDisplay = GaugeWidgetBuilder(
                        _title,
                        _value,
                        _min,
                        _max,
                        _minSafeValue,
                        _maxSafeValue,
                        _minWarningValue,
                        _maxWarningValue,
                        _minDangerValue,
                        _maxDangerValue);
                  },
                );
              },
            ),
            _sliderFunction(
              title: "Danger Area Ranges",
              color: Colors.red,
              minValue: _maxWarningValue,
              maxValue: _max,
              values: SfRangeValues(_minDangerValue, _maxDangerValue),
              onChanged: (values) {
                setState(
                  () {
                    _minDangerValue = values.start;
                    _maxDangerValue = values.end;
                    _gaugeWidgetDisplay = GaugeWidgetBuilder(
                        _title,
                        _value,
                        _min,
                        _max,
                        _minSafeValue,
                        _maxSafeValue,
                        _minWarningValue,
                        _maxWarningValue,
                        _minDangerValue,
                        _maxDangerValue);
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 8,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Add"),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
