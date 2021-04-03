import 'package:bluetooth/bluetooth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bluetooth/ui/bluetooth_view.dart';
import 'package:flutter_blue/flutter_blue.dart';

final bluetoohHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BlueToothView();
});

final deviceViewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  final device = context.settings.arguments as BluetoothDevice;
  return DeviceDetailsView(
    device: device,
  );
});
