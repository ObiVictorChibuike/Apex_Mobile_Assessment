import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/color_palette.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60,),
        Center(child: Container(
          height: 90,
          width: 90,
          color: Colors.transparent,
          child: const Icon(Icons.warning_rounded,size:  25, color: kRedPink,)
        ),),
        const SizedBox(height: 8,),
        Text("An Error Occurred. Please try again", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: const Color(0xFF52575C), fontSize: 14),)
      ],
    );
  }
}