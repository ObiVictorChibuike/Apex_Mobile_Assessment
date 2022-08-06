import 'package:assessment/core/routes/app_routes.dart';
import 'package:assessment/presentation/modules/intro_screens/onboarding/views/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/login/view/login.dart';
import '../../../auth/sign_up/view/sign_up.dart';
import 'onboarding_contents.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  List colors = [const Color(0xffDAD3C8), const Color(0xffFFE5DE), const Color(0xffDCF6E6)];

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50),), color: Color(0xFF000000),),
      margin: const EdgeInsets.only(right: 5), height: 10, curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    double blockH = SizeConfig.blockH!;
    double blockV = SizeConfig.blockV!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 3,
              child: PageView.builder(controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value), itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Image.asset(contents[i].image, height: SizeConfig.blockV! * 35,),
                        SizedBox(height: (height >= 840) ? 60 : 30,),
                        Text(contents[i].title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: (width <= 550) ? 30 : 35,),
                        ),
                        const SizedBox(height: 15,),
                        Text(
                          contents[i].desc,
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: (width <= 550) ? 17 : 25,),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                          (int index) => _buildDots(index: index),
                    ),
                  ),
                  _currentPage + 1 == contents.length
                      ? Padding(
                    padding: const EdgeInsets.all(30),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(()=> const SignUp());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: (width <= 550)
                            ? const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 20)
                            : EdgeInsets.symmetric(
                            horizontal: width * 0.2, vertical: 25),
                        textStyle:
                        TextStyle(fontSize: (width <= 550) ? 13 : 17),
                      ),
                      child: const Text("START"),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _controller.jumpToPage(2);
                          },
                          style: TextButton.styleFrom(
                            elevation: 0,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: (width <= 550) ? 13 : 17,
                            ),
                          ),
                          child: const Text("SKIP", style: TextStyle(color: Colors.black),),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            padding: (width <= 550)
                                ? const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20)
                                : const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 25),
                            textStyle: TextStyle(
                                fontSize: (width <= 550) ? 13 : 17),
                          ),
                          child: const Text("NEXT"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}