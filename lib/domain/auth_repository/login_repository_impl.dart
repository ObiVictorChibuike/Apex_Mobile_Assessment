import 'package:assessment/data/models/login_user_response.dart';
import 'package:assessment/data/remote/dio_config/dio_data_state.dart';
import 'package:assessment/data/remote/dio_config/dio_error_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../app/constants/app_string/strings.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../core/use_cases/use_cases.dart';

class LoginUser implements useCase<DataState<LoginResponse>, LoginParam> {
  final AuthRepository _authRepository;

  LoginUser(this._authRepository);

  @override
  Future<DataState<LoginResponse>> execute({required LoginParam params}) async{
    try {
      final response = await _authRepository.login(email: params.phoneNumber!, password: params.password!, deviceName: params.deviceName!);
      if (response!.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
        return DataSuccess(LoginResponse.fromJson(response.data));
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      return DataFailed(err.response?.data[Strings.error] ?? errorMessage);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return DataFailed(err.toString());
    }
  }
}

class LoginParam{
  final String? phoneNumber;
  final String? password;
  final String? deviceName;
  LoginParam(this.phoneNumber, this.password, this.deviceName);
}

