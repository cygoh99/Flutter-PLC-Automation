import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plc_app/widget/baseWidget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../demo.dart';
import '../widgetClass.dart';

class TextInputWidgetBuilder extends BaseWidgetBuilder {
  late String _displayText;

  TextInputWidgetBuilder({
    super.key,
    required String title,
    String? displayText,
  }) : super(title: title) {
    _displayText = displayText!;
  }

  @override
  State<TextInputWidgetBuilder> createState() => _TextInputWidgetBuilderState();
}

class _TextInputWidgetBuilderState extends State<TextInputWidgetBuilder> {
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Input',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextInputWidgeSetting extends BaseWidgetSetting {
  const TextInputWidgeSetting({super.key});

  @override
  State<TextInputWidgeSetting> createState() => _TextInputWidgeSettingState();
}

class _TextInputWidgeSettingState extends State<TextInputWidgeSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const ImageIcon(
          AssetImage('assets/icons/icons8-textInput-67.png'),
        ),
        title: const Text("Text Input"),
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TextInputWidgeSettingUI()),
            )),
      ),
    );
  }
}

class TextInputWidgeSettingUI extends StatefulWidget {
  const TextInputWidgeSettingUI({super.key});

  @override
  State<TextInputWidgeSettingUI> createState() =>
      _TextInputWidgeSettingUIState();
}

class _TextInputWidgeSettingUIState extends State<TextInputWidgeSettingUI> {
  late TextInputWidgetBuilder _terminalWidgetDisplay;

  @override
  void initState() {
    super.initState();
    _terminalWidgetDisplay = TextInputWidgetBuilder(
      title: 'Demo',
      displayText:
          'Enter your message',
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
                      _terminalWidgetDisplay = TextInputWidgetBuilder(
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
