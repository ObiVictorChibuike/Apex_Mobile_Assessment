import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/constants/app_string/strings.dart';

class LocalCachedData{
  final SharedPreferences _prefs;
  LocalCachedData._(this._prefs);
  static Future<LocalCachedData> create() async => LocalCachedData._(await SharedPreferences.getInstance());
  static LocalCachedData get instance => Get.find<LocalCachedData>();

  Future<String?> getPhoneNumber() async {
    String? phone = _prefs.getString(Strings.phone);
    return phone;
  }

  Future<void> cachePhoneNumber({required String? phone}) async {
    _prefs.setString(Strings.phone, phone!);
  }


  // Future<void> cacheDriverProfileData({required DriverProfileData driverProfileData }) async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setString(Strings.driverProfile, json.encode(driverProfileData.toJson()));
  // }
  //
  // Future<DriverProfileData?> getDriverProfileData() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   String? userData = sharedPreferences.getString(Strings.driverProfile);
  //   return userData == null ? null : DriverProfileData.fromJson(jsonDecode(userData));
  // }

  Future<bool> getLoginStatus() async {
    bool? userData = _prefs.getBool(Strings.checkLoginStatus);
    return userData ?? false;
  }

  Future<void> cacheLoginStatus({required bool isLoggedIn}) async {
    _prefs.setBool(Strings.checkLoginStatus, isLoggedIn);
  }
}