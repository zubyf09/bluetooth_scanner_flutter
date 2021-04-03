import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:values/values.dart';
import 'package:widgets/text.dart';

class DeviceTile extends StatelessWidget {
  const DeviceTile({Key key, this.result, this.onTap}) : super(key: key);

  final ScanResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: _buildTitle(context),
      leading: Text(result.rssi.toString()),
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText(
            text: result.device.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            textStyle: Style.fontNormal(color: AppColors.black, size: 14.0),
          ),
          AppText(
            text: result.device.id.toString(),
            textAlign: TextAlign.start,
            textStyle: Style.fontNormal(color: AppColors.black, size: 14.0),
          )
        ],
      );
    } else {
      return AppText(
        text: result.device.id.toString(),
        textAlign: TextAlign.start,
        textStyle: Style.fontNormal(color: AppColors.black, size: 14.0),
      );
    }
  }
}
