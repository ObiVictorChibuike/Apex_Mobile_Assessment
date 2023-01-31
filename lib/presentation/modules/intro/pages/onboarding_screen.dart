import 'package:assessment/app/shared_widget/button_widget.dart';
import 'package:assessment/app/utils/asset_path.dart';
import 'package:assessment/app/utils/color_palette.dart';
import 'package:assessment/presentation/modules/auth/login/view/login.dart';
import 'package:assessment/presentation/modules/intro/controller/onboarding_controller.dart';
import 'package:assessment/presentation/modules/intro/widget/index_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  GetBuilder<OnBoardingController>(
        init: OnBoardingController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
            child: Scaffold(
              body: Column(
                children: [Flexible(
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: height, viewportFraction: 1.0,
                        enlargeCenterPage: false, autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState((){
                            controller.currentIndex = index;
                          });
                        }
                    ),
                    items: [
                      Center(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 0.0, left: 0.0, right: 0.0, top: 150,
                              child: Image.asset(AssetPath.obMobile1, fit: BoxFit.contain, height: height/1.5,
                              ),
                            ),
                            Positioned(
                              bottom: 0.0, left: 0.0, right: 0.0,
                              child: Container(
                                height: height * 0.1,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      white,
                                      white,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 30.0, left: 0.0, right: 0.0,
                              child: Container(
                                height: height * 0.1,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      white,
                                      white.withOpacity(0.8),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 210, top: 150,
                              child: Image.asset(AssetPath.lock, fit: BoxFit.fill, height: 100,),
                            ),
                            Positioned(
                              right: 10, top: 280,
                              child: Image.asset(AssetPath.monthChart, fit: BoxFit.fill, height: 150,),
                            ),
                            Positioned(
                              right: 160, top: 350,
                              child: Image.asset(AssetPath.directPosition, fit: BoxFit.fill, height: 120,),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 0.0, left: 0.0, right: 0.0, top: 150,
                              child: Image.asset(AssetPath.obMobile1, fit: BoxFit.contain, height: height/1.5,
                              ),
                            ),
                            Positioned(
                              bottom: 0.0, left: 0.0, right: 0.0,
                              child: Container(
                                height: height * 0.1,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      white,
                                      white,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 30.0, left: 0.0, right: 0.0,
                              child: Container(
                                height: height * 0.1,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      white,
                                      white.withOpacity(0.8),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 35, top: 280,
                              child: Image.asset(AssetPath.contact, fit: BoxFit.fill, height: 150,),
                            ),
                            Positioned(
                              right: 160, top: 180,
                              child: Image.asset(AssetPath.payment, fit: BoxFit.fill, height: 120,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                  Container(
                    width: width,
                    height: height /2.6,
                    color: white,
                    child: Column(
                      children: [
                        Flexible(
                          child: Text(controller.changeOnBoardingHeaderIndex()!, textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ebony, fontWeight: FontWeight.w600, fontSize: 24)
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                            child: Text(controller.changeOnBoardingMessageIndex()!, textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: paleSky, fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(2, (index) => IndexIndicator(color:  controller.currentIndex == index ? ebony : athensGray,
                                  width: controller.currentIndex == index ? 25.0 : 5)
                              ),
                            ]
                        ),
                        const SizedBox(height: 34,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: ButtonWidget(
                            borderRadius: 16, buttonColor: ebony,
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                            }, buttonText: 'Get Started',
                            height: 56, width: double.maxFinite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}


