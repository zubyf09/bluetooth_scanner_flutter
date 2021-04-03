import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:values/values.dart';
import 'package:widgets/text.dart';

class DeviceDetailsView extends StatelessWidget {
  final BluetoothDevice device;

  const DeviceDetailsView({Key key, this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: AppText(
                  text: 'Device is ${snapshot.data.toString().split('.')[1]}.',
                  textAlign: TextAlign.start,
                  textStyle:
                      Style.fontNormal(color: AppColors.black, size: 14.0),
                ),
                subtitle: AppText(
                  text: '${device.id}',
                  textAlign: TextAlign.start,
                  textStyle:
                      Style.fontNormal(color: AppColors.black, size: 14.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
