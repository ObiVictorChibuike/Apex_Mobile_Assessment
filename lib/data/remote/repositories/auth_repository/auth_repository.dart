import 'package:dio/dio.dart';

import '../../services/auth_services/auth_services.dart';

class AuthRepository {
  final AuthServices _authServices;
  AuthRepository(this._authServices);

  Future<Response> signUp({required String phoneNumber,required String password}) => _authServices.signUp(phoneNumber: phoneNumber, password: password);

  Future<Response> login({required String phoneNumber, required String password}) => _authServices.login(phoneNumber: phoneNumber, password: password);


}