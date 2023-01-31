import 'dart:developer';

import 'package:assessment/app/constants/app_string/strings.dart';
import 'package:assessment/app/shared_widget/button_widget.dart';
import 'package:assessment/app/shared_widget/cutom_formfield_widget.dart';
import 'package:assessment/app/utils/color_palette.dart';
import 'package:assessment/app/utils/flush_bar_loader.dart';
import 'package:assessment/app/utils/loading_dialog.dart';
import 'package:assessment/app/utils/validator.dart';
import 'package:assessment/core/state/view_state.dart';
import 'package:assessment/presentation/modules/auth/registration/controller/controller.dart';
import 'package:assessment/presentation/modules/auth/registration/view/set_pincode.dart';
import 'package:assessment/presentation/modules/auth/registration/view/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

class AboutYourself extends StatefulWidget {
  const AboutYourself({Key? key}) : super(key: key);

  @override
  State<AboutYourself> createState() => _AboutYourselfState();
}

class _AboutYourselfState extends State<AboutYourself> {
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final countryCodeController = TextEditingController();
  final passwordController = TextEditingController();
  final formKeySignUp = GlobalKey <FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller){
          void registerUser(BuildContext context, SignUpController controller)async{
            if(formKeySignUp.currentState!.validate()){
              ProgressDialogHelper().loadingState;
              await controller.registerUser(fullName: fullNameController.text.trim(),
                  userName: userNameController.text.trim(), email: emailController.text.trim(),
                  country: countryCodeController.text.trim(), password: passwordController.text.trim());
              if(controller.viewState.state == ResponseState.COMPLETE){
                ProgressDialogHelper().loadStateTerminated;
                Get.offAll(()=> const SuccessScreen());
                FlushBarHelper(context, "Registration Successful").showErrorBar;
              }else if(controller.viewState.state == ResponseState.ERROR){
                ProgressDialogHelper().loadStateTerminated;
                FlushBarHelper(context, controller.errorMessage ?? Strings.errorOccurred).showErrorBar;
              }
            }
          }
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
              child: ListView(
                  children: [
                    const SizedBox(height: 30,),
                    RichText(textAlign: TextAlign.start, text: const TextSpan(text: "Hey there! tell us a bit \nabout ",
                        style: TextStyle(color: ebony, fontWeight: FontWeight.w600, fontSize: 24,),
                        children: [
                          TextSpan(text: "yourself", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: atoll)),
                        ]
                    )),
                    const SizedBox(height: 32,),
                    FormFieldWidget(
                      controller: fullNameController,
                      hintText: "Full name",
                      validator: Validator.isFullName,
                    ),
                    const SizedBox(height: 16,),
                    FormFieldWidget(
                      controller: userNameController,
                      hintText: "Username",
                      validator: Validator.isName,
                    ),
                    const SizedBox(height: 16,),
                    FormFieldWidget(
                      controller: countryController,
                      validator: Validator.isRequired,
                      onTap: (){
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                            bottomSheetHeight: 500, // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country){
                            setState(() {
                              countryController.text = country.name;
                              log(country.countryCode);
                              countryCodeController.text = country.countryCode;
                            });
                          },
                        );
                      },
                      hintText: "Select Country",
                        suffixIcon: Icon(Icons.keyboard_arrow_down, color: paleSky,),
                    ),
                    const SizedBox(height: 16,),
                    FormFieldWidget(
                      validator: Validator.isStrongPassword,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1, textInputAction: TextInputAction.done,
                      hintText: "Password", obscureText: controller.isObscuredText,
                      suffixIcon: IconButton(onPressed: (){
                        controller.toggleObscuredText();
                      }, icon: Icon(controller.isObscuredText == false ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: paleSky,)),
                    ),
                    const SizedBox(height: 24,),
                    ButtonWidget(onPressed: (){
                      registerUser(context,controller);
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> const SetPinCode()));
                    },
                      buttonText: "Continue",
                      height: 56, borderRadius: 16, buttonTextStyle: const TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 16),
                      width: double.maxFinite, buttonColor: paleSky,
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
