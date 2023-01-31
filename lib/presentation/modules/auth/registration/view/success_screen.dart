import 'package:assessment/app/shared_widget/button_widget.dart';
import 'package:assessment/app/utils/asset_path.dart';
import 'package:assessment/app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(backgroundColor: white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetPath.success, height: 100, width: 100),
                  const SizedBox(height: 32,),
                  const Text("Verify it’s you", style: TextStyle(color: ebony, fontSize: 24, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 12,),
                  const Text("You’ve completed the onboarding \nyou can start using", textAlign: TextAlign.center,
                    style: TextStyle(color: ebony, fontSize: 16, fontWeight: FontWeight.w400),),
                  const SizedBox(height: 32,),
                  ButtonWidget(onPressed: (){

                  },
                    buttonText: "Get Started",
                    height: 56, borderRadius: 16, buttonTextStyle: const TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 16),
                    width: double.maxFinite, buttonColor: ebony,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
