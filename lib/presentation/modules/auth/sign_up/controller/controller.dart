import 'package:assessment/data/remote/services/auth_services/auth_services.dart';
import 'package:assessment/domain/auth_repository/signup_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import '../../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import 'package:dio/dio.dart' as dio;

class SignUpController extends GetxController{
  final _signUp = Get.put(SignUpUser(AuthRepository(AuthServices())));
  final formKeySignUp = GlobalKey <FormState>();
  final scaffoldKeySignUp = GlobalKey <ScaffoldState>();
  //Variable
  String? errorMessage;
  bool? isObscuredText = false;

  //Form Controllers
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  //Initialize State
  ViewState<dio.Response> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<dio.Response> viewState) {
    this.viewState = viewState;
  }

  void toggleObscuredText(){
    isObscuredText = !isObscuredText!;
    update();
  }

  Future<void> signUp()async{
    await _signUp.execute(params: SignUpParam(phoneNumberController.text.trim(), passwordController.text.trim())).then((value) async {
      if(value is DataSuccess || value.data?.data != null) {
        await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true).whenComplete(() async{
          await LocalCachedData.instance.cachePhoneNumber(phone: phoneNumberController.text);
          _setViewState(ViewState.complete(value.data!));
          update();
        });
      }
      if (value is DataFailed || value.data?.data == null) {
        if (kDebugMode) {
          print(value.error.toString());
        }
        errorMessage = value.error.toString();
        _setViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }


  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> onInitializeLocalStorage() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    super.onInit();
  }

  @override
  void onInit() {
    onInitializeLocalStorage();
    super.onInit();
  }

}