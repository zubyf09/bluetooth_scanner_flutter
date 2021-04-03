import 'package:bluetooth/ui/device_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:navigation/config/application.dart';
import 'package:values/values.dart';
import 'package:widgets/text.dart';
import 'package:navigation/navigation.dart';
import 'device_detail_view.dart';

class SearchDevicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: CString.availableDevices,
          textStyle: Style.fontNormal(color: AppColors.white, size: 16.0),
        ),
      ),
      body: StreamBuilder<List<ScanResult>>(
        stream: FlutterBlue.instance.scanResults,
        initialData: [],
        builder: (c, snapshot) => Column(
          children: snapshot.data
              .map(
                (result) => DeviceTile(
                  result: result,
                  onTap: () {
                    moveToDeviceDetailView(context, result.device);
                  },
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () => FlutterBlue.instance.stopScan(),
                backgroundColor: AppColors.red50);
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }

  moveToDeviceDetailView(BuildContext context, BluetoothDevice device) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Application.router.navigateTo(context, Routes.detailView,
          routeSettings: RouteSettings(arguments: device));
    });
  }
}
