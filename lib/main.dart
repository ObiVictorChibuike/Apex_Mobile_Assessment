import 'package:assessment/presentation/modules/auth/login/view/login.dart';
import 'package:assessment/presentation/modules/intro/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'show kIsWeb;
import 'dart:io';
import 'package:get/get.dart';
import 'app/utils/app_theme.dart';
import 'data/local/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final loginStatus = await LocalCachedData.instance.getLoginStatus();

  runApp(MyApp(loginStatus: loginStatus,));
}

class MyApp extends StatelessWidget {
  final bool? loginStatus;
  const MyApp({Key? key, this.loginStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,));
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.applicationTheme(),
          home: loginStatus == true ?  const LoginScreen() : const OnBoardingScreen(),
          //const OnBoardingScreen()
      ),
    );
  }
}

