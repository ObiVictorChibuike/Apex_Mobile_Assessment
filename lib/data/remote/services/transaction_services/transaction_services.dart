import 'dart:convert';
import 'package:dio/dio.dart';
import '../../dio/dio_network_client.dart';

class TransactionServices{
  Future<Response> transfer({required String phoneNumber, required amount}){
    var postBody = jsonEncode({
      "phoneNumber": phoneNumber,
      "amount": amount
    });
    final response = DioClient().dio.post("/accounts/transfer", data: postBody);
    return response;
  }


  Future<Response> withdrawal({required String phoneNumber, required amount}){
    var postBody = jsonEncode({
      "phoneNumber": phoneNumber,
      "amount": amount
    });
    final response = DioClient().dio.post("/accounts/withdraw", data: postBody);
    return response;
  }


  Future<Response> getAllTransactions() async {
    final response = await DioClient().dio.get("/transactions");
    return response;
  }


  Future<Response> getAccountList() async {
    final response = await DioClient().dio.get("/accounts/list");
    return response;
  }
}