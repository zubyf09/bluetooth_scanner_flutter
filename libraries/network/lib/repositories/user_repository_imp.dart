import 'dart:collection';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:network/model/base_model.dart';
import 'package:network/model/server_error.dart';
import 'package:package_info/package_info.dart';
import '../network_provider.dart';
import 'interface/user_repository.dart';

class UserRepositoryImp {
  UserRepository userRepository;

  UserRepositoryImp() {
    //userRepository = new UserRepository(NetworkProvider.instance());
  }


  Future<BaseModel<Response>> getRating() async {

    var response;
    try {
      //response = await userRepository.getRating(auth: user.token,storeType: Constants.STORE_TYPE);
    } catch (error, stacktrace) {
      //print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

}

