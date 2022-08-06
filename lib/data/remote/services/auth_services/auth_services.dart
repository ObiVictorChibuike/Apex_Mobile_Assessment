import 'dart:convert';
import 'package:assessment/data/remote/dio/dio_network_client.dart';
import 'package:dio/dio.dart';

class AuthServices{
  Future<Response> signUp({required String phoneNumber, required password}){
    var postBody = jsonEncode({
      "phoneNumber": phoneNumber,
      "password": password
    });
    final response = DioClient().dio.post("/auth/signup", data: postBody);
    return response;
  }

  Future<Response> login({required String phoneNumber, required password}){
    var postBody = jsonEncode({
      "phoneNumber": phoneNumber,
      "password": password
    });
    final response = DioClient().dio.post("/auth/login", data: postBody);
    return response;
  }
}