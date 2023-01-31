import 'package:assessment/app/shared_widget/button_widget.dart';
import 'package:assessment/app/utils/color_palette.dart';
import 'package:assessment/presentation/modules/auth/registration/controller/controller.dart';
import 'package:assessment/presentation/modules/auth/registration/view/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SetPinCode extends StatefulWidget {
  const SetPinCode({Key? key}) : super(key: key);

  @override
  State<SetPinCode> createState() => _SetPinCodeState();
}

class _SetPinCodeState extends State<SetPinCode> {
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
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView(children: [
                  const SizedBox(height: 30,),
                  const Text("Set your PIN code", style: TextStyle(color: ebony, fontSize: 24, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 12,),
                  const Text("We use state-of-the-art security measures to protect your information at all times", style: TextStyle(color: paleSky, fontSize: 16, fontWeight: FontWeight.w400),),
                  const SizedBox(height: 32,),

                  const SizedBox(height: 131,),
                  ButtonWidget(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SuccessScreen()));
                  },
                    buttonText: "Create PIN",
                    height: 56, borderRadius: 16, buttonTextStyle: const TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 16),
                    width: double.maxFinite, buttonColor: paleSky,
                  ),
                ]),
              ),
            ),
          );
        });
  }
}
