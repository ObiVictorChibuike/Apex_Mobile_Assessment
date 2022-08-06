import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../data/remote/dio/dio_data_state.dart';
import '../../../../data/remote/dio/dio_error_handling.dart';
import '../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../app/constants/app_string/strings.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../core/use_cases/use_cases.dart';

class SignUpUser implements useCase<DataState<Response>, SignUpParam> {
  final AuthRepository _authRepository;
  SignUpUser(this._authRepository);

  @override
  Future<DataState<Response>> execute({required SignUpParam params}) async{
    try {
      final response = await _authRepository.signUp(phoneNumber: params.phoneNumber!,password: params.password!);
      if (response.statusCode == HttpResponseStatus.success || response.statusCode == HttpResponseStatus.ok) {
        return DataSuccess(response);
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      if (kDebugMode) {
        print(err);
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

class SignUpParam{
  final String? phoneNumber;
  final String? password;

  SignUpParam(this.phoneNumber, this.password);
}