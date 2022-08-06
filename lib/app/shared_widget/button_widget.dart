import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final double? height;
  final double? width;
  final TextStyle? buttonTextStyle;
  final double? borderRadius;
  const ButtonWidget({Key? key,required this.onPressed,required this.buttonText, this.buttonColor, required this.height, required this.width, this.buttonTextStyle, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      child: SizedBox(height: height ?? 55, width: width ?? double.maxFinite,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0, primary: buttonColor),
          onPressed: onPressed,
          child: Text(buttonText, style: buttonTextStyle ?? Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
        ),
      ),
    );
  }
}