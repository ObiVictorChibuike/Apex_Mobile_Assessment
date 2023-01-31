import 'package:assessment/data/models/get_email_token_response.dart';
import 'package:assessment/data/models/register_user_response.dart';
import 'package:assessment/data/models/verify_email_token_response.dart';
import 'package:assessment/data/remote/dio_config/dio_data_state.dart';
import 'package:assessment/data/remote/services/auth_services/auth_services.dart';
import 'package:assessment/domain/auth_repository/get_email_token_repository_impl.dart';
import 'package:assessment/domain/auth_repository/register_repository_impl.dart';
import 'package:assessment/domain/auth_repository/verify_email_token_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:device_information/device_information.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../../../data/remote/repositories/auth_repository/auth_repository.dart';

class SignUpController extends GetxController{
  final getToken = Get.put(GetEmailToken(AuthRepository(AuthServices())));
  final verifyToken = Get.put(VerifyEmailToken(AuthRepository(AuthServices())));
  final register = Get.put(RegisterUser(AuthRepository(AuthServices())));

  //Variable
  String? errorMessage;
  bool? isObscuredText = false;
  String? deviceDetail;

  //Form Controllers
  final emailController = TextEditingController();
  final pinCode = TextEditingController();

  //Initialize GetEmailToken State
  ViewState<GetEmailTokenResponse> viewState = ViewState(state: ResponseState.EMPTY);
  void _setViewState(ViewState<GetEmailTokenResponse> viewState) {
    this.viewState = viewState;
  }

//Initialize VerifyEmailToken State
  ViewState<VerifyEmailTokenResponse> verifyEmailTokenResponseViewState = ViewState(state: ResponseState.EMPTY);
  void _setVerifyEmailTokenResponseViewState(ViewState<VerifyEmailTokenResponse> verifyEmailTokenResponseViewState) {
    this.verifyEmailTokenResponseViewState = verifyEmailTokenResponseViewState;
  }

  //Initialize VerifyEmailToken State
  ViewState<RegisterUserResponse> registerUserResponseViewState = ViewState(state: ResponseState.EMPTY);
  void _setRegisterUserResponseViewState(ViewState<RegisterUserResponse> registerUserResponseViewState) {
    this.registerUserResponseViewState = registerUserResponseViewState;
  }

  void toggleObscuredText(){
    isObscuredText = !isObscuredText!;
    update();
  }

  Future<void> getEmailToken()async{
    await getToken.execute(params: GetEmailTokenParam(emailController.text.trim())).then((value) async {
      if(value is DataSuccess || value.data != null) {
        _setViewState(ViewState.complete(value.data!));
        update();
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

  /// Function to verify Email Token
  Future<void> verifyEmailToken()async{
    await verifyToken.execute(params: VerifyEmailTokenParam(emailController.text.trim(), pinCode.text.trim())).then((value) async {
      if(value is DataSuccess || value.data != null) {
        await LocalCachedData.instance.cacheEmail(email: value.data!.data!.email);
        _setVerifyEmailTokenResponseViewState(ViewState.complete(value.data!));
        update();
      }
      if (value is DataFailed || value.data?.data == null) {
        if (kDebugMode) {
          print(value.error.toString());
        }
        errorMessage = value.error.toString();
        _setVerifyEmailTokenResponseViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  /// Function to get Device Name
  Future<String> getDeviceName() async {
    var deviceName = await DeviceInformation.deviceName;
    final device = await DeviceInformation.deviceModel;
    final manufacturer = await DeviceInformation.deviceManufacturer;
    print("$manufacturer $device $deviceName");
    deviceDetail = "$manufacturer $device $deviceName";
    return "$manufacturer $device $deviceName";
  }

  Future<void> registerUser({required String fullName, required String userName, required String email,
    required String country, required String password})async{
    await register.execute(params: RegisterUserParam(fullName, userName, email, country, password, deviceDetail)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        await LocalCachedData.instance.cacheAuthToken(token: value.data!.data!.token);
        await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true);
        _setRegisterUserResponseViewState(ViewState.complete(value.data!));
        update();
      }
      if (value is DataFailed || value.data?.data == null) {
        if (kDebugMode) {
          print(value.error.toString());
        }
        errorMessage = value.error.toString();
        _setRegisterUserResponseViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }


  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> onInitializeLocalStorage() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    super.onInit();
  }

  @override
  void onInit() {
    onInitializeLocalStorage();
    getDeviceName();
    super.onInit();
  }

}