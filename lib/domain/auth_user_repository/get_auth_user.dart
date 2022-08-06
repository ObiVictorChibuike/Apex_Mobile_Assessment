import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../app/constants/app_string/strings.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../core/use_cases/use_cases.dart';
import '../../data/models/auth_user_model.dart';
import '../../data/remote/dio/dio_data_state.dart';
import '../../data/remote/dio/dio_error_handling.dart';
import '../../data/remote/repositories/auth_user_repository/user_repository.dart';

class GetAuthUser implements noParamUseCases<DataState<AuthUserResponseModel>> {
  final AuthUserRepository _authUserRepository;
  GetAuthUser(this._authUserRepository);

  @override
  Future<DataState<AuthUserResponseModel>> noParamCall() async{
    try {
      final response = await _authUserRepository.getAuthUsers();
      if (response.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {;
      return DataSuccess(AuthUserResponseModel.fromJson(response.data));
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