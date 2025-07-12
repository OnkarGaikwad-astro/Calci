import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothScannerPage extends StatefulWidget {
  @override
  _BluetoothScannerPageState createState() => _BluetoothScannerPageState();
}

class _BluetoothScannerPageState extends State<BluetoothScannerPage> {
  final flutterBlue = FlutterBluePlus.instance;
  final List<ScanResult> scanResults = [];

  @override
  void initState() {
    super.initState();
    requestPermissions().then((_) => startScan());
  }

  Future<void> requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();
  }

  void startScan() {
    FlutterBluePlus.startScan(timeout: Duration(seconds: 4));
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        scanResults.clear();
        scanResults.addAll(results);
      });
    });
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan(); // Static method
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BLE Scanner')),
      body: scanResults.isEmpty
          ? Center(child: Text("No BLE devices found"))
          : ListView.builder(
              itemCount: scanResults.length,
              itemBuilder: (context, index) {
                final result = scanResults[index];
                return ListTile(
                  title: Text(result.device.name.isEmpty
                      ? '(Unknown Device)'
                      : result.device.name),
                  subtitle: Text(result.device.id.toString()),
                  trailing: Text('RSSI: ${result.rssi}'),
                );
              },
            ),
    );
  }
}
