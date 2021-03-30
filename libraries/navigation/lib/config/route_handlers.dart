import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:signin/ui/sign_in_view.dart';




final splashHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignInView();
});

// final searchAddressHandler =
//     Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
//   String param = params['address'][0];
//   Address address = Address.fromJson(decodeJsonData(param));
//   return MapAddress(
//     address: address,
//   );
// });

