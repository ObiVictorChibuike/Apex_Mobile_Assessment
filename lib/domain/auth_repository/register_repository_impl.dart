import 'package:assessment/data/models/register_user_response.dart';
import 'package:assessment/data/remote/dio_config/dio_data_state.dart';
import 'package:assessment/data/remote/dio_config/dio_error_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../app/constants/app_string/strings.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../core/use_cases/use_cases.dart';

class RegisterUser implements useCase<DataState<RegisterUserResponse>, RegisterUserParam> {
  final AuthRepository _authRepository;
  RegisterUser(this._authRepository);

  @override
  Future<DataState<RegisterUserResponse>> execute({required RegisterUserParam params}) async{
    try {
      final response = await _authRepository.register(fullName: params.fullName!,
          userName: params.userName!, email: params.email!, country: params.country!,
          password: params.password!, deviceName: params.deviceName!);
      if (response!.statusCode == HttpResponseStatus.success || response.statusCode == HttpResponseStatus.ok) {
        return DataSuccess(RegisterUserResponse.fromJson(response.data));
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(err);
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

class RegisterUserParam{
  final String? fullName;
  final String? userName;
  final String? email;
  final String? country;
  final String? password;
  final String? deviceName;
  RegisterUserParam(this.fullName, this.userName, this.email, this.country, this.password, this.deviceName);
}