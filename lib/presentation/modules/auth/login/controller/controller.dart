import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import '../../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../../../../data/remote/services/auth_services/auth_services.dart';
import '../../../../../domain/auth_repository/login_repository.dart';

class LoginController extends GetxController{

  void toggleObscuredText(){
    isObscuredText = !isObscuredText!;
    update();
  }

  final _login = Get.put(SignInUser(AuthRepository(AuthServices())));
  final formKeyLogin = GlobalKey <FormState>();
  final scaffoldKeyLogin = GlobalKey <ScaffoldState>();

  //Variable
  String? errorMessage;
  bool? isObscuredText = true;

  //Form Controllers
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  //Initialize State
  ViewState<dio.Response> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<dio.Response> viewState) {
    this.viewState = viewState;
  }

  Future<void> login()async{
    await _login.execute(params: SignInParam(phoneNumberController.text.trim(), passwordController.text.trim())).then((value) async {
      if(value is DataSuccess || value.data?.data != null) {
        await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true).whenComplete(() async {
          await LocalCachedData.instance.cachePhoneNumber(phone: phoneNumberController.text);
          _setViewState(ViewState.complete(value.data!));
          update();
        });
      }
      if (value is DataFailed || value.data?.data == null) {
        if (kDebugMode) {
          print("This is the error ${value.error}");
        }
        errorMessage = value.error;
        update();
        _setViewState(ViewState.error(value.error.toString()));
      }}
    );
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

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}