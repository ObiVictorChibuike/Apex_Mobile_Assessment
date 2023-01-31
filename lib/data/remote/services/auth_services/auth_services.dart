import 'dart:convert';
import 'package:assessment/data/remote/dio_config/dio_network_client.dart';
import 'package:dio/dio.dart';

class AuthServices{
  Future<Response?> getEmailToken({required String email}){
    var postBody = jsonEncode({
      "email": email,
    });
    final response = NetworkProvider().call(path: "/api/v1/auth/register", method: RequestMethod.post, body: postBody);
    return response;
  }

  Future<Response?> verifyEmailToken({required String email, required token}){
    var postBody = jsonEncode({
      "email": email,
      "token": token
    });
    final response = NetworkProvider().call(path: "/api/v1/auth/email/verify", method: RequestMethod.post, body: postBody);
    return response;
  }

  Future<Response?> login({required String email, required String password, required String deviceName}){
    var postBody = jsonEncode({
      "email": email,
      "password": password,
      "device_name": deviceName
    });
    final response = NetworkProvider().call(path: "/api/v1/auth/login", method: RequestMethod.post, body: postBody);
    return response;
  }

  Future<Response?> register({required String fullName, required String userName, required String email,
    required String country, required String password, required String deviceName}){
    var postBody = jsonEncode({
      "full_name": fullName,
      "username": userName,
      "email": email,
      "country": country,
      "password": password,
      "device_name": deviceName
    });
    final response = NetworkProvider().call(path: "/api/v1/auth/register", method: RequestMethod.post, body: postBody);
    return response;
  }


}