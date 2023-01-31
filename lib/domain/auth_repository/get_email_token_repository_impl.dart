import 'package:assessment/data/models/get_email_token_response.dart';
import 'package:assessment/data/remote/dio_config/dio_data_state.dart';
import 'package:assessment/data/remote/dio_config/dio_error_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../app/constants/app_string/strings.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../core/use_cases/use_cases.dart';

class GetEmailToken implements useCase<DataState<GetEmailTokenResponse>, GetEmailTokenParam> {
  final AuthRepository _authRepository;
  GetEmailToken(this._authRepository);

  @override
  Future<DataState<GetEmailTokenResponse>> execute({required GetEmailTokenParam params}) async{
    try {
      final response = await _authRepository.getEmailToken(email: params.email!);
      if (response!.statusCode == HttpResponseStatus.success || response.statusCode == HttpResponseStatus.ok) {
        return DataSuccess(GetEmailTokenResponse.fromJson(response.data));
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

class GetEmailTokenParam{
  final String? email;

  GetEmailTokenParam(this.email,);
}