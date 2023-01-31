import 'package:assessment/data/models/verify_email_token_response.dart';
import 'package:assessment/data/remote/dio_config/dio_data_state.dart';
import 'package:assessment/data/remote/dio_config/dio_error_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../app/constants/app_string/strings.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../core/use_cases/use_cases.dart';

class VerifyEmailToken implements useCase<DataState<VerifyEmailTokenResponse>, VerifyEmailTokenParam> {
  final AuthRepository _authRepository;
  VerifyEmailToken(this._authRepository);

  @override
  Future<DataState<VerifyEmailTokenResponse>> execute({required VerifyEmailTokenParam params}) async{
    try {
      final response = await _authRepository.verifyEmailToken(email: params.email!, token:  params.token!);
      if (response!.statusCode == HttpResponseStatus.success || response.statusCode == HttpResponseStatus.ok) {
        return DataSuccess(VerifyEmailTokenResponse.fromJson(response.data));
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

class VerifyEmailTokenParam{
  final String? email;
  final String? token;
  VerifyEmailTokenParam(this.email, this.token);
}