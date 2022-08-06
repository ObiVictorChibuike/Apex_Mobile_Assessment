import 'package:assessment/app/utils/flush_bar_loader.dart';
import 'package:assessment/presentation/modules/auth/login/view/login.dart';
import 'package:assessment/presentation/modules/auth/sign_up/controller/controller.dart';
import 'package:assessment/presentation/modules/dashboard/home/views/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../app/constants/app_string/strings.dart';
import '../../../../../app/shared_widget/button_widget.dart';
import '../../../../../app/shared_widget/clipper.dart';
import '../../../../../app/shared_widget/cutom_formfield_widget.dart';
import '../../../../../app/utils/asset_path.dart';
import '../../../../../app/utils/color_palette.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/utils/validator.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/state/view_state.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  void signUp(BuildContext context, SignUpController controller)async{
    if(controller.formKeySignUp.currentState!.validate()){
      ProgressDialogHelper().loadingState;
      await controller.signUp();
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAll(()=> const HomeScreen());
      }else if(controller.viewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, controller.errorMessage ?? Strings.errorOccurred).showErrorBar;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
        builder: (controller){
      return Scaffold(
        key: controller.scaffoldKeySignUp,
        body: Stack(children: [
          ClipPath(
              clipper: ClippingClass(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: primaryGradient),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    )),
              )),
          Container(
            padding: const EdgeInsets.only(left: 35, top: 60),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Create\nAccount With", style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                const Text("Expense\nManager", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w400),),
                Align(alignment: Alignment.topCenter,
                  child: Lottie.asset(AssetPath.createAccount, height: 150, width: 180),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(right: 35, left: 35,
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Form(
                key: controller.formKeySignUp,
                child: Column(children: [
                  FormFieldWidget(
                    controller: controller.phoneNumberController,
                    hintText: "Phone Number",
                    validator: Validator.isPhone,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FormFieldWidget(
                    validator: Validator.isStrongPassword,
                    controller: controller.passwordController,
                    maxLines: 1,
                    hintText: "Password", obscureText: controller.isObscuredText,
                    suffixIcon: IconButton(onPressed: (){
                      controller.toggleObscuredText();
                    }, icon: Icon(controller.isObscuredText == false ? Icons.visibility : Icons.visibility_off, color: Colors.black,)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ButtonWidget(onPressed: (){
                    signUp(context, controller);
                  },
                    buttonText: "REGISTER",
                    height: 50, borderRadius: 8, buttonTextStyle: const TextStyle(color: kWhite),
                    width: double.maxFinite, buttonColor: Colors.black,
                  ),
                  const SizedBox(height: 40,),
                  Align(alignment: Alignment.bottomCenter,
                    child: RichText(textAlign: TextAlign.center, text: TextSpan(text: "Already have an account?  ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12,),
                        children: [
                          TextSpan(text: "Login", recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offAll(()=> const LoginScreen());
                            },
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, decoration: TextDecoration.underline)),
                        ]
                    )),
                  ),
                ]),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
