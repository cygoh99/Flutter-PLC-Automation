import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DeviceListScreen extends StatelessWidget {
  const DeviceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device List'),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref().child('devices').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.snapshot.value;
            if (data != null) {
              final devices = Map<String, dynamic>.from(data as Map);
              return ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices.entries.elementAt(index).value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: Card(
                      child: ListTile(
                        title: Text(device['name']),
                        subtitle: const Text('234-123-435'),
                        leading: const Icon(
                          Icons.precision_manufacturing,
                          size: 50,
                        ),
                        trailing: const Icon(Icons.more_vert),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WidgetListScreen(
                                  deviceId: devices.keys.elementAt(index)),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class WidgetListScreen extends StatelessWidget {
  final String deviceId;

  const WidgetListScreen({Key? key, required this.deviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget List'),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child('devices/$deviceId/widgets')
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.snapshot.value;
            if (data != null) {
              final widgets = Map<String, dynamic>.from(data as Map);
              return ListView.builder(
                itemCount: widgets.length,
                itemBuilder: (context, index) {
                  final widget = widgets.entries.elementAt(index).value;
                  return ListTile(
                    title: Text(widget['name']),
                  );
                },
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        
      ),
    );
  }
}
