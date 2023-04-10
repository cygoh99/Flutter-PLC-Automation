import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

abstract class BaseWidget {
  String _title;

  BaseWidget(this._title);

  void setTitle(String title) {
    _title = title;
  }

  Widget buildContent() {
    return Container();
  }

  Future<void> settingContent(BuildContext context) async {
    return showDialog<void>(
        builder: (BuildContext context) {
          return Container();
        },
        context: context);
  }
}

class GaugeWidget extends BaseWidget {
  double _value;
  double _min;
  double _max;
  double _minSafeValue;
  double _maxSafeValue;
  double _minWarningValue;
  double _maxWarningValue;
  double _minDangerValue;
  double _maxDangerValue;

  GaugeWidget(
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
  ) : super(title);

  @override
  Widget buildContent() {
    return SizedBox(
      height: 300,
      child: SfRadialGauge(
        title: GaugeTitle(
          text: _title,
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

  @override
  Future<void> settingContent(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Gauge Setting'),
          content: const Text('Customize your Widget'),
          scrollable: true,
          actions: <Widget>[
            buildContent(),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
              onChanged: (text) {
                setTitle(text);
              },
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
