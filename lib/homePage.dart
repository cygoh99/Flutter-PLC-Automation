import 'package:flutter/material.dart';
import 'package:plc_app/demo.dart';

import 'deviceList.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Welcome!"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DemoPage()),
              );
            },
            child: const Text('Demo App'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeviceListScreen()),
              );
            },
            child: const Text('Device List'),
          ),
        ],
      ),
    );
  }
}
