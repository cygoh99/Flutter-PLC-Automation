import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plc_app/widget/baseWidget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../demo.dart';
import '../widgetClass.dart';

class TerminalWidgetBuilder extends BaseWidgetBuilder {
  late String _displayText;

  TerminalWidgetBuilder({
    Key? key,
    required String title,
    String? displayText,
  }) : super(title: title) {
    _displayText = displayText!;
  }

  @override
  State<TerminalWidgetBuilder> createState() => _TerminalWidgetBuilderState();
}

class _TerminalWidgetBuilderState extends State<TerminalWidgetBuilder> {
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
              height: 120,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black54,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget._displayText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'Courier New',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TerminalWidgetSetting extends BaseWidgetSetting {
  const TerminalWidgetSetting({super.key});

  @override
  State<TerminalWidgetSetting> createState() => _TerminalWidgetSettingState();
}

class _TerminalWidgetSettingState extends State<TerminalWidgetSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const ImageIcon(
          AssetImage('assets/icons/icons8-console-50.png'),
        ),
        title: const Text("Terminal"),
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TerminalWidgetSettingUI()),
            )),
      ),
    );
  }
}

class TerminalWidgetSettingUI extends StatefulWidget {
  const TerminalWidgetSettingUI({super.key});

  @override
  State<TerminalWidgetSettingUI> createState() =>
      _TerminalWidgetSettingUIState();
}

class _TerminalWidgetSettingUIState extends State<TerminalWidgetSettingUI> {
  late TerminalWidgetBuilder _terminalWidgetDisplay;

  @override
  void initState() {
    super.initState();
    _terminalWidgetDisplay = TerminalWidgetBuilder(
      title: 'Terminal',
      displayText:
          'D/ViewRootImpl[MainActivity](15611): dispatchPointerEvent handled=true, event=MotionEvent { action=ACTION_UP, actionButton=0, id[0]=0, x[0]=76.0, y[0]=153.0, toolType[0]=TOOL_TYPE_FINGER, buttonState=0, classification=NONE, metaState=0, flags=0x0, edgeFlags=0x0, pointerCount=1, historySize=0, eventTime=424123928, downTime=424123816, deviceId=3, source=0x1002, displayId=0 }',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terminal Builder"),
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
                      _terminalWidgetDisplay = TerminalWidgetBuilder(
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
