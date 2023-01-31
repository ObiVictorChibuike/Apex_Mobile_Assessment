import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String? buttonText;
  final Color? buttonColor;
  final Color? boundaryColor;
  final double? height;
  final double? width;
  final TextStyle? buttonTextStyle;
  final double? borderRadius;
  final Widget? buttonIcon;
  const ButtonWidget({Key? key,required this.onPressed, this.buttonText, this.buttonColor, required this.height, required this.width, this.buttonTextStyle, this.borderRadius, this.buttonIcon, this.boundaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(height: height ?? 55, width: width ?? double.maxFinite, decoration:
      BoxDecoration(border: Border.all(color: boundaryColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius ?? 8), color: buttonColor),
        child: Center(child: buttonIcon ?? Text(buttonText ?? "", style: buttonTextStyle ?? Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)),
      ),
    );
  }
}