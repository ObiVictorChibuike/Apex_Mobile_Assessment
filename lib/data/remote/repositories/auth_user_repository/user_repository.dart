import 'package:dio/dio.dart';
import '../../services/user_services/user_services.dart';

class AuthUserRepository{
  final AuthUserServices _authUserServices;
  AuthUserRepository(this._authUserServices);
  Future<Response> getAuthUsers()=> _authUserServices.getAuthUsers();
}