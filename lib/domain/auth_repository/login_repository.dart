import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../data/remote/dio/dio_error_handling.dart';
import '../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../app/constants/app_string/strings.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../core/use_cases/use_cases.dart';
import '../../data/remote/dio/dio_data_state.dart';

class SignInUser implements useCase<DataState<Response>, SignInParam> {
  final AuthRepository _authRepository;

  SignInUser(this._authRepository);

  @override
  Future<DataState<Response>> execute({required SignInParam params}) async{
    try {
      final response = await _authRepository.login(phoneNumber: params.phoneNumber!, password: params.password!);
      if (response.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
        return DataSuccess(response);
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      if (kDebugMode) {
        print(errorMessage);
      }
      return DataFailed(err.response?.data[Strings.error].toString() ?? errorMessage);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return DataFailed(err.toString());
    }
  }
}

class SignInParam{
  final String? phoneNumber;
  final String? password;

  SignInParam(this.phoneNumber, this.password);
}

