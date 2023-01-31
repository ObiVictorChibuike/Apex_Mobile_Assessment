import 'package:assessment/app/constants/app_string/strings.dart';
import 'package:assessment/app/shared_widget/button_widget.dart';
import 'package:assessment/app/shared_widget/cutom_formfield_widget.dart';
import 'package:assessment/app/utils/asset_path.dart';
import 'package:assessment/app/utils/color_palette.dart';
import 'package:assessment/app/utils/flush_bar_loader.dart';
import 'package:assessment/app/utils/loading_dialog.dart';
import 'package:assessment/app/utils/validator.dart';
import 'package:assessment/core/state/view_state.dart';
import 'package:assessment/presentation/modules/auth/login/view/login.dart';
import 'package:assessment/presentation/modules/auth/registration/controller/controller.dart';
import 'package:assessment/presentation/modules/auth/registration/view/verify_email.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKeySignUp = GlobalKey <FormState>();
  SignUpController _controller = Get.put(SignUpController(), permanent: true);


  void signUp(BuildContext context, SignUpController controller)async{
    if(formKeySignUp.currentState!.validate()){
      ProgressDialogHelper().loadingState;
      await controller.getEmailToken();
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAll(()=> const VerifyEmail());
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
            key: formKeySignUp,
            child: ListView(
                children: [
                  const SizedBox(height: 30,),
                  RichText(textAlign: TextAlign.start, text: const TextSpan(text: "Create a ",
                      style: TextStyle(color: ebony, fontWeight: FontWeight.w600, fontSize: 24,),
                      children: [
                        TextSpan(text: "Smartpay", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: atoll)),
                        TextSpan(text: "\naccount", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: ebony)),
                      ]
                  )),
                  const SizedBox(height: 32,),
                  FormFieldWidget(
                    controller: controller.emailController,
                    hintText: "Email",
                    validator: Validator.isValidEmailAddress,
                  ),
                  const SizedBox(height: 24,),
                  ButtonWidget(onPressed: (){
                    signUp(context, controller);
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> const VerifyEmail()));
                  },
                    buttonText: "Sign Up",
                    height: 56, borderRadius: 16, buttonTextStyle: const TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 16),
                    width: double.maxFinite, buttonColor: ebony,
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
                  const SizedBox(
                    height: 90,
                  ),
                  Align(alignment: Alignment.bottomCenter,
                    child: RichText(textAlign: TextAlign.center, text:
                    TextSpan(text: "Already have an account?  ", style: const TextStyle(color: paleSky, fontWeight: FontWeight.w400, fontSize: 12,),
                        children: [
                          TextSpan(text: "Login", recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offAll(()=> const LoginScreen());
                            },
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: atoll)),
                        ]
                    )),
                  ),
                ]
            ),
          ),
        ),
      );
    });
  }
}
