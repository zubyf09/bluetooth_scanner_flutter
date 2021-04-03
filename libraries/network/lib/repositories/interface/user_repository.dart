import 'package:dio/dio.dart';
import 'package:network/utils/api_constants.dart';
import 'package:retrofit/retrofit.dart';


@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class UserRepository {
 // factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  // @POST("/customer/verifyOtp")
  // Future<Response> verifyOtp({@Body() Response otpVerifyRequest});

  @GET("/customer/card")
  Future<Response> getData(@Header("Authorization") String auth);


}
