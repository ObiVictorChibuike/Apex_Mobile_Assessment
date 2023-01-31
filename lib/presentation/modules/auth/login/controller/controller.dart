import 'dart:developer';

import 'package:assessment/data/models/login_user_response.dart';
import 'package:assessment/data/remote/dio_config/dio_data_state.dart';
import 'package:assessment/data/remote/repositories/auth_repository/auth_repository.dart';
import 'package:assessment/data/remote/services/auth_services/auth_services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import 'package:device_information/device_information.dart';
import '../../../../../domain/auth_repository/login_repository_impl.dart';

class LoginController extends GetxController{

  void toggleObscuredText(){
    isObscuredText = !isObscuredText!;
    update();
  }

  final _login = Get.put(LoginUser(AuthRepository(AuthServices())));

  //Variable
  String? errorMessage;
  bool? isObscuredText = true;
  String? deviceDetail;

  //Form Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Initialize State
  ViewState<LoginResponse> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<LoginResponse> viewState) {
    this.viewState = viewState;
  }

  Future<String> getDeviceName() async {
    var deviceName = await DeviceInformation.deviceName;
    final device = await DeviceInformation.deviceModel;
    final manufacturer = await DeviceInformation.deviceManufacturer;
    print("$manufacturer $device $deviceName");
    deviceDetail = "$manufacturer $device $deviceName";
    log(deviceName.toString());
    return "$manufacturer $device $deviceName";
  }

  Future<void> login()async{
    await _login.execute(params: LoginParam(emailController.text.trim(), passwordController.text.trim(), deviceDetail!)).then((value) async {
      if(value is DataSuccess || value.data?.data != null) {
        await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true).whenComplete(() async {
          await LocalCachedData.instance.cacheAuthToken(token: value.data!.data!.token!);
          await LocalCachedData.instance.cacheEmail(email: value.data!.data!.user!.email!);
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
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    if (isLoggedIn == true) {
      final email = await LocalCachedData.instance.getAuthEmail();
      emailController.text = email!;
    }
    super.onInit();
  }

  @override
  void onInit() {
    onInitializeLocalStorage();
    getDeviceName();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}