import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:values/values.dart';
import 'package:widgets/text.dart';

class BluetoothOffView extends StatelessWidget {
  final BluetoothState bluetoothState;

  const BluetoothOffView({Key key, this.bluetoothState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 250.0,
              color: Colors.white,
            ),
            AppText(
              text:
              'Bluetooth is ${bluetoothState != null ? bluetoothState.toString().substring(15) : 'not available'}.',
              textStyle: Style.fontBold(color: AppColors.lightGrey, size: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
