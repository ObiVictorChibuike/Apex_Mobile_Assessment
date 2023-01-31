import 'package:assessment/presentation/modules/auth/login/controller/controller.dart';
import 'package:assessment/presentation/modules/auth/registration/view/sign_up.dart';
import 'package:assessment/presentation/modules/auth/registration/view/success_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/constants/app_string/strings.dart';
import '../../../../../app/shared_widget/button_widget.dart';
import '../../../../../app/shared_widget/cutom_formfield_widget.dart';
import '../../../../../app/utils/asset_path.dart';
import '../../../../../app/utils/color_palette.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/utils/validator.dart';
import '../../../../../core/state/view_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {
  final formKeyLogin = GlobalKey <FormState>();
  final scaffoldKeyLogin = GlobalKey <ScaffoldState>();

  void loginUser(BuildContext context, LoginController controller)async{
    if(formKeyLogin.currentState!.validate()){
      formKeyLogin.currentState!.save();
      ProgressDialogHelper().loadingState;
      await controller.login();
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAll(()=> const SuccessScreen());
        FlushBarHelper(context, "Login Successful").showErrorBar;
      }else if(controller.viewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, controller.errorMessage == Strings.emptyString ? Strings.internalServerError : controller.errorMessage).showErrorBar;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            elevation: 0, backgroundColor: white,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5),
              child: Container(
                height: 40, width: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: paleSky)),
                child: const Icon(Icons.arrow_back_ios_new, color: ebony,),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: formKeyLogin,
              child: ListView(children: [
                const SizedBox(height: 30,),
                const Text("Hi There! 👋", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),),
                const SizedBox(height: 8,),
                const Text("Welcome back, Sign in to your account", style: TextStyle(color: paleSky, fontSize: 16, fontWeight: FontWeight.w400),),
                const SizedBox(height: 32,),
                    FormFieldWidget(
                      controller: controller.emailController,
                      hintText: "Email",
                      validator: Validator.isValidEmailAddress,
                    ),
                    const SizedBox(height: 16,),
                    FormFieldWidget(
                      validator: Validator.isStrongPassword,
                      controller: controller.passwordController, keyboardType: TextInputType.visiblePassword,
                      maxLines: 1, textInputAction: TextInputAction.done,
                      hintText: "Password", obscureText: controller.isObscuredText,
                      suffixIcon: IconButton(onPressed: (){
                        controller.toggleObscuredText();
                      }, icon: Icon(controller.isObscuredText == false ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.black,)),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text("Forgot Password?", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: atoll, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 24,
                ),
                    ButtonWidget(onPressed: (){
                      loginUser(context, controller);
                    },
                      buttonText: "Sign In",
                      height: 56, borderRadius: 16, buttonTextStyle: const TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 16),
                      width: double.maxFinite, buttonColor: Colors.black,
                    ),
                const SizedBox(
                  height: 42.5,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 1,  width: MediaQuery.of(context).size.width / 3, color: athensGray,),
                    Text("OR", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: paleSky, fontSize: 14, fontWeight: FontWeight.w400)),
                    Container(height: 1,  width: MediaQuery.of(context).size.width / 3, color: athensGray,),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWidget(
                      boundaryColor: paleSky,
                      onPressed: (){
                    },
                      buttonIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(AssetPath.google, height: 20, width: 20),
                      ),
                      width: MediaQuery.of(context).size.width /2.5, borderRadius: 16,
                      buttonTextStyle: const TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 16),
                      height: 56, buttonColor: white,
                    ),
                    ButtonWidget(
                      boundaryColor: paleSky,
                      onPressed: (){
                    },
                      buttonIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(AssetPath.apple, height: 20, width: 20),
                      ),
                      width: MediaQuery.of(context).size.width /2.5, borderRadius: 16, buttonTextStyle: const TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 16),
                      height: 56, buttonColor: white,
                    ),
                  ],
                ),
                const SizedBox(height: 180,),
                RichText(textAlign: TextAlign.center, text: TextSpan(text: "Don't have an account?  ",
                    style: const TextStyle(color: paleSky, fontWeight: FontWeight.w400, fontSize: 12,),
                    children: [
                      TextSpan(text: "Create Account", recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.offAll(()=> const SignUp());
                        },
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: atoll)),
                    ]
                ))
              ]),
            ),
          ),
        ),
      );
    });
  }
}
