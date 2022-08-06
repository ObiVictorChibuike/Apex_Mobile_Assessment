import '../../dio/dio_network_client.dart';
import 'package:dio/dio.dart';

class AuthUserServices{
  Future<Response> getAuthUsers() async {
    final response = await DioClient().dio.get("/auth/users");
    return response;
  }
}