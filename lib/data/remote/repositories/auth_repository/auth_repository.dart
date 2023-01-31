import 'package:dio/dio.dart';

import '../../services/auth_services/auth_services.dart';

class AuthRepository {
  final AuthServices _authServices;
  AuthRepository(this._authServices);

  Future<Response?> getEmailToken({required String email}) => _authServices.getEmailToken(email: email);

  Future<Response?> verifyEmailToken({required String email, required String token}) => _authServices.verifyEmailToken(email: email, token: token);

  Future<Response?> login({required String email, required String password, required String deviceName}) => _authServices.login(email: email, password: password, deviceName: deviceName);

  Future<Response?> register({required String fullName, required String userName, required String email,
    required String country, required String password, required String deviceName}) => _authServices.register(fullName: fullName, userName: userName, email: email, country: country, password: password, deviceName: deviceName);


}