import 'package:flutter/material.dart';
import 'package:values/values.dart';
import 'package:widgets/text.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final name = TextEditingController();


  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context2) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Center(
          child: AppText(
            text: "Create a username",
            textStyle: Style.fontNormal(color:Colors.black,size: 12.0),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.black26),
              borderRadius: BorderRadius.circular(7.0)),
          child: TextField(
            controller: name,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10.0),
                labelText: "Username",
                labelStyle: TextStyle(fontSize: 15.0)),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          if (name.text == null || name.text.length == 0){
            return;
          }
          Navigator.pop(context, name.text);
        },
          child: Container(
        width: 350.0,
        height: 50.0,
        child: Center(
            child: AppText(
              text: "Next",
              textStyle: Style.fontBold(color:Colors.white,size: 15.0),

        )),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(7.0)),
      ))
    ]);
  }
}
