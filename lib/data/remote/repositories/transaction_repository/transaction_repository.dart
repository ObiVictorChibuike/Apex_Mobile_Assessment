import 'package:assessment/data/remote/services/transaction_services/transaction_services.dart';
import 'package:dio/dio.dart';

class TransactionRepository{
  final TransactionServices _transactionServices;
  TransactionRepository(this._transactionServices);
  Future<Response> transfer({required String phoneNumber, required amount}) => _transactionServices.transfer(phoneNumber: phoneNumber, amount: amount);
  Future<Response> withdrawal({required String phoneNumber, required amount}) => _transactionServices.withdrawal(phoneNumber: phoneNumber, amount: amount);
  Future<Response> getAllTransactions() => _transactionServices.getAllTransactions();
  Future<Response> getAccountList() => _transactionServices.getAccountList();
}