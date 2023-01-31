import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCachedData{
  final SharedPreferences _prefs;
  LocalCachedData._(this._prefs);
  static Future<LocalCachedData> create() async => LocalCachedData._(await SharedPreferences.getInstance());
  static LocalCachedData get instance => Get.find<LocalCachedData>();

  ///return user email
  Future<String?> getAuthEmail() async {
    String? email = _prefs.getString("email");
    return email;
  }

  /// cache user email
  Future<void> cacheEmail({required String? email}) async {
    _prefs.setString("email", email!);
  }

  /// return auth token
  Future<String?> getAuthToken() async {
    String? token = _prefs.getString('token');
    return token;
  }

  /// cache auth token
  Future<void> cacheAuthToken({required String? token}) async {
    _prefs.setString("token", token!);
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
/// return a bool that monitor login status
  Future<bool> getLoginStatus() async {
    bool? userData = _prefs.getBool("loginStatus");
    return userData ?? false;
  }

  /// cache login status
  Future<void> cacheLoginStatus({required bool isLoggedIn}) async {
    _prefs.setBool("loginStatus", isLoggedIn);
  }
}