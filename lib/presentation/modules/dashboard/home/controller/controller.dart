import 'package:assessment/data/remote/repositories/transaction_repository/transaction_repository.dart';
import 'package:assessment/data/remote/services/transaction_services/transaction_services.dart';
import 'package:assessment/domain/transaction_repository/withdraw.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../app/utils/asset_path.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/models/account_model.dart';
import '../../../../../data/models/auth_user_model.dart';
import '../../../../../data/models/transaction_model.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import '../../../../../data/remote/repositories/auth_user_repository/user_repository.dart';
import '../../../../../data/remote/services/user_services/user_services.dart';
import '../../../../../domain/auth_user_repository/get_auth_user.dart';
import '../../../../../domain/transaction_repository/get_account_list.dart';
import '../../../../../domain/transaction_repository/get_transaction.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../../domain/transaction_repository/transfer.dart';

class HomeScreenController extends GetxController{
  final _getTransactionList = Get.put(GetTransactions(TransactionRepository(TransactionServices())));
  final _getAuthUserList = Get.put(GetAuthUser(AuthUserRepository(AuthUserServices())));
  final _getAccountList = Get.put(GetAccountList(TransactionRepository(TransactionServices())));
  final _withdraw = Get.put(WithDrawCash(TransactionRepository(TransactionServices())));
  final _transfer = Get.put(TransferCash(TransactionRepository(TransactionServices())));
  String? errorMessage;
  final withdrawalPhoneNumberController = TextEditingController();
  final withdrawalAmountController = TextEditingController();

  final transferPhoneNumberController = TextEditingController();
  final transferAmountController = TextEditingController();

  final formKeyTransaction = GlobalKey <FormState>();
  ViewState<TransactionModelResponse> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<TransactionModelResponse> viewState) {
    this.viewState = viewState;
  }

  Future<void> getTransaction()async{
    _setViewState(ViewState.loading());
    await _getTransactionList.noParamCall().then((value) async {
      if(value is DataSuccess || value.data != null) {
        _setViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error);
        }errorMessage = value.error.toString();
        update();
        _setViewState(ViewState.error(value.error.toString()));
      }}
    );
  }

  bool? amountToggle = false;

  void toggleAmount(){
    amountToggle = !amountToggle!;
    update();
  }

  ViewState<AuthUserResponseModel> authUserServicesViewState = ViewState(state: ResponseState.EMPTY);

  void _setAuthUserViewState(ViewState<AuthUserResponseModel> authUserServicesViewState) {
    this.authUserServicesViewState = authUserServicesViewState;
  }

  Future<void> getAuthUser()async{
    _setAuthUserViewState(ViewState.loading());
    await _getAuthUserList.noParamCall().then((value) async {
      if(value is DataSuccess || value.data != null) {
        _setAuthUserViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error);
        }errorMessage = value.error.toString();
        update();
        _setAuthUserViewState(ViewState.error(value.error.toString()));
      }}
    );
  }


  ViewState<AccountListResponseModel> accountListViewState = ViewState(state: ResponseState.EMPTY);

  void _setAccountListViewState(ViewState<AccountListResponseModel> accountListViewState) {
    this.accountListViewState = accountListViewState;
  }

  ViewState<dio.Response>  amountWithdrawalViewState = ViewState(state: ResponseState.EMPTY);

  void _setWithdrawViewState(ViewState<dio.Response> withdrawalViewState) {
    amountWithdrawalViewState = withdrawalViewState;
  }


  Future<void> getAccountList()async{
    _setAccountListViewState(ViewState.loading());
    await _getAccountList.noParamCall().then((value) async {
      if(value is DataSuccess || value.data != null) {
        _setAccountListViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error);
        }errorMessage = value.error.toString();
        update();
        _setAccountListViewState(ViewState.error(value.error.toString()));
      }}
    );
  }


  Future<void> withdrawal()async{
    await _withdraw.execute(params: WithdrawalParam(withdrawalPhoneNumberController.text.trim(), withdrawalAmountController.text.trim())).then((value) async {
      if(value is DataSuccess || value.data != null) {
        withdrawalPhoneNumberController.clear();
        withdrawalAmountController.clear();
        _setWithdrawViewState(ViewState.complete(value.data!));
          update();
      }
      if (value is DataFailed || value.data?.data == null) {
        if (kDebugMode) {
          print("This is the error ${value.error}");
        }
        errorMessage = value.error;
        update();
        _setWithdrawViewState(ViewState.error(value.error.toString()));
      }}
    );
  }

  Future<void> transfer()async{
    await _transfer.execute(params: TransferParam(transferPhoneNumberController.text.trim(), transferAmountController.text.trim())).then((value) async {
      if(value is DataSuccess || value.data != null) {
        transferPhoneNumberController.clear();
        transferAmountController.clear();
        _setWithdrawViewState(ViewState.complete(value.data!));
        update();
      }
      if (value is DataFailed || value.data?.data == null) {
        if (kDebugMode) {
          print("This is the error ${value.error}");
        }
        errorMessage = value.error;
        update();
        _setWithdrawViewState(ViewState.error(value.error.toString()));
      }}
    );
  }



  final carouselHeadings = [
    {
      "title": "Loan is less than 5 mins",
      "message": "Reliable disbursement",
      "image_path": AssetPath.carouselPic1,
    },
    {
      "title": "Seamless repayment",
      "message": "Flexible repayment options",
      "image_path": AssetPath.carouselPic2,
    },
    {
      "title": "Don’t be left behind!",
      "message": "Repay early to enjoy better loan offer",
      "image_path": AssetPath.carouselPic3
    },
  ];


  @override
  void dispose() {
    withdrawalPhoneNumberController.dispose();
    withdrawalAmountController.dispose();
    transferPhoneNumberController.dispose();
    transferAmountController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    getTransaction();
    getAuthUser();
    getAccountList();
    super.onInit();
  }
}