import 'dart:async';

import 'package:assessment/app/constants/app_string/strings.dart';
import 'package:assessment/app/shared_widget/button_widget.dart';
import 'package:assessment/app/shared_widget/custom_timer.dart';
import 'package:assessment/app/shared_widget/numeric_keyboard.dart';
import 'package:assessment/app/utils/color_palette.dart';
import 'package:assessment/app/utils/flush_bar_loader.dart';
import 'package:assessment/app/utils/loading_dialog.dart';
import 'package:assessment/app/utils/validator.dart';
import 'package:assessment/core/state/view_state.dart';
import 'package:assessment/presentation/modules/auth/registration/controller/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'about_yourself.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

  String? otp;
  String? errors;
  int time = 120;
  late Timer timer;
  final formKeySignUp = GlobalKey <FormState>();

  /// To start the countdown
  void startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (time == 0) {
        t.cancel();
        time = 120;
      } else {
        if (mounted) {
          setState(() {
            time--;
          });
        }
      }
    });
  }


  @override
  void initState() {
    startCountdown();
    super.initState();
  }


  ///Function to verify Email
  void verifyEmail(BuildContext context, SignUpController controller)async{
    if(formKeySignUp.currentState!.validate()){
      ProgressDialogHelper().loadingState;
      await controller.verifyEmailToken();
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAll(()=> const AboutYourself());
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
              body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30,),
                          const Text("Verify it’s you", style: TextStyle(color: ebony, fontSize: 24, fontWeight: FontWeight.w600),),
                          const SizedBox(height: 12,),
                          const Text("We send a code to ( *****@mail.com ). Enter it here to verify your identity", style: TextStyle(color: paleSky, fontSize: 16, fontWeight: FontWeight.w400),),
                          const SizedBox(height: 32,),
                          PinCodeTextField(
                            appContext: context,
                            keyboardType: TextInputType.number,
                            length: 6,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            autoDisposeControllers: true,
                            autoFocus: false,
                            cursorColor: ebony,
                            showCursor: true,
                            autoDismissKeyboard: true,
                            boxShadows: const [
                              BoxShadow(
                                color: Colors.black12,
                              ),
                            ],
                            pinTheme: PinTheme(
                              activeColor: Colors.green,
                              selectedColor: ebony,
                              inactiveColor: white,
                              inactiveFillColor: mercury,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: paleSky,
                            ),
                            animationDuration: const Duration(milliseconds: 300),
                            controller: controller.pinCode,
                            validator: Validator.isOtp,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                //currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          ),
                          const SizedBox(height: 32,),
                          Align(alignment: Alignment.center,
                              child: time == 0 ? GestureDetector(
                                onTap: (){
                                  startCountdown();
                                },
                                child: Text("Resend",
                                  style: TextStyle(color: paleSky, fontSize: 16, fontWeight: FontWeight.w700),),
                              ):
                              Text("Resend Code ${getTimeForCountDown(time)} secs",
                                style: TextStyle(color: paleSky, fontSize: 16, fontWeight: FontWeight.w700),)),
                          const SizedBox(height: 67,),
                          ButtonWidget(onPressed: (){
                            verifyEmail(context, controller);
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> const AboutYourself()));
                          },
                            buttonText: "Confirm",
                            height: 56, borderRadius: 16, buttonTextStyle: const TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 16),
                            width: double.maxFinite, buttonColor: paleSky,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(color: white),
                      padding: const EdgeInsets.all(50),
                      child: NumericKeyboard(
                        onKeyboardTap: (String value) {
                          setState(() {
                            controller.pinCode.text = controller.pinCode.text + value;
                          });
                        }, rightButtonFn: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          controller.pinCode.text = controller.pinCode.text
                              .substring(0, controller.pinCode.text.length - 1);
                        });
                        // emailVerifySuccessful(context);
                      },
                      ),
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                  ]
              ),
            ),
          );
        });
  }
}
