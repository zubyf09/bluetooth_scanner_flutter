import 'package:flutter/material.dart';
import 'package:values/values.dart';
import 'package:widgets/text.dart';

class AppButtonOutline extends StatelessWidget {
  final String label;
  final Function onPress;
  final bool disabled;
  final double elevation;
  final double height;
  final double width;
  final Color color;
  final Color borderColor;
  final TextStyle textStyle;
  final double borderRadius;

  const AppButtonOutline(
      {Key key,
      this.textStyle,
      this.label,
      this.onPress,
      this.color,
      this.height = Dimens.buttonHeight,
      this.width,
      this.elevation = 1,
        this.borderColor,
        this.borderRadius,
      this.disabled=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //alignment: Alignment.center,
        child: FlatButton(
          height: height,
        minWidth: width,    
        disabledColor: color??AppColors.darkGrey,
            color: color ?? AppColors.brownishGray,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: disabled?AppColors.hintTextColor:borderColor,
                  width: 1,
                  style: BorderStyle.solid
              ),
                borderRadius: BorderRadius.circular(borderRadius)
            ),
            
            onPressed: disabled?null:onPress,
            child: Text(label ?? "",
                style: disabled?Style.archivo(
                    color: AppColors.hintTextColor,
                    size: 18.0) :textStyle, textAlign: TextAlign.center))


    );
  }
}
