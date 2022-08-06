import 'package:assessment/presentation/modules/auth/login/controller/controller.dart';
import 'package:assessment/presentation/modules/auth/login/view/login.dart';
import 'package:assessment/presentation/modules/auth/sign_up/controller/controller.dart';
import 'package:assessment/presentation/modules/auth/sign_up/view/sign_up.dart';
import 'package:get/get.dart';
import '../../presentation/modules/dashboard/home/controller/controller.dart';
import '../../presentation/modules/dashboard/home/views/home_screen.dart';

class Routes {

  static const home = '/home';
  static const login ='/login';
  static const signup = '/signup';
}

// This is simple and will allow you use nested navigation
class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.login,
      transition: Transition.circularReveal,
      page: () => const LoginScreen(),
        binding: BindingsBuilder(() {
          Get.put(LoginController(),);
        })
    ),

    GetPage(
        name: Routes.signup,
        transition: Transition.circularReveal,
        page: () => const SignUp(),
        binding: BindingsBuilder(() {
          Get.put(SignUpController(),);
        })
    ),

    GetPage(
        name: Routes.home,
        page: () => const HomeScreen(),
        transition: Transition.circularReveal,
        binding: BindingsBuilder(() {
          Get.put(HomeScreenController(),);
        })
    ),

  ];
}