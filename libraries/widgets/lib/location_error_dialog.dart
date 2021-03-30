import 'package:flutter/material.dart';
import 'package:values/values.dart';
import 'package:widgets/text.dart';

class LocationErrorDialog extends StatelessWidget {
  final String title, description, buttonText1, buttonText2;
  final Function onPressed1, onPressed2;

  LocationErrorDialog(
      {this.title,
      this.description,
      this.buttonText1,
      this.buttonText2,
      this.onPressed1,
      this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      //elevation: 10,
      //backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AppText(
                    text: description,
                    textStyle: Style.fontNormal(
                        color: AppColors.brownishGray, size: 16.0),
                    maxLines: 20,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    minFontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                  child: AppText(
                    text: buttonText1,
                    textStyle:
                        Style.fontNormal(color: AppColors.green, size: 14.0),
                    maxLines: 20,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    minFontSize: 14,
                  ),
                  onPressed: onPressed1),
              FlatButton(
                  child: AppText(
                    text: buttonText2,
                    textStyle:
                        Style.fontNormal(color: AppColors.green, size: 14.0),
                    maxLines: 20,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    minFontSize: 14,
                  ),
                  onPressed: onPressed2),
            ],
          ),
        ],
      ),
    );
  }
}
