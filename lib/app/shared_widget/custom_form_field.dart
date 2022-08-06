import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_palette.dart';

class AppTextField extends StatefulWidget {
  final bool isPassword;
  final TextAlign? textAlign;
  final String? labelText;
  final String? hintText;
  final TextStyle? style;
  final String Function(String?)? validator;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final InputBorder? inputBorder;
  final InputBorder? enabledBorder;
  final int? maxLines;
  final bool? hasLabel;
  final bool hideBorder;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function()? onTap;
  final List<TextInputFormatter>? formatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? errorText;
  final bool? filled;
  final bool inputError;
  final FocusNode? focusNode;

  const AppTextField({
    Key? key,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.filled,
    this.textAlign,
    this.initialValue,
    this.maxLines = 1,
    this.style,
    this.validator,
    this.inputError = false,
    this.hideBorder = false,
    this.isPassword = false,
    this.inputBorder,
    this.enabledBorder,
    this.onChanged,
    this.formatters,
    this.readOnly = false,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.errorText,
    this.focusNode,

    this.hasLabel
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) => TextFormField(
    initialValue: widget.initialValue,
      textInputAction: TextInputAction.next, keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: kGrayScale1, width: 0.7)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: kGrayScale1, width: 0.7)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: kGrayScale1, width: 0.7)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: kGrayScale1, width: 0.7)
        ),
        fillColor: kGrayScale1,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.all(15),
      ),
      cursorColor: Colors.black,
      validator: (value) {
        if(value!.isEmpty) {
          return "Please enter your phone number";
        }else if (value.length < 6){
          return "Please enter a valid phone number";
        }
        return null;
      }
  );
}
