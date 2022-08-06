import 'package:assessment/data/remote/repositories/transaction_repository/transaction_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../app/constants/app_string/strings.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../core/use_cases/use_cases.dart';
import '../../data/models/transaction_model.dart';
import '../../data/remote/dio/dio_data_state.dart';
import '../../data/remote/dio/dio_error_handling.dart';

class GetTransactions implements noParamUseCases<DataState<TransactionModelResponse>> {
  final TransactionRepository _transactionRepository;
  GetTransactions(this._transactionRepository);

  @override
  Future<DataState<TransactionModelResponse>> noParamCall() async{
    try {
      final response = await _transactionRepository.getAllTransactions();
      if (response.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {;
      return DataSuccess(TransactionModelResponse.fromJson(response.data));
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