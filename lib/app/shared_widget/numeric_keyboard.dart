import 'package:assessment/app/utils/color_palette.dart';
import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Widget? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Widget? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  const NumericKeyboard(
      {Key? key,
        required this.onKeyboardTap,
        this.textColor = Colors.black,
        this.rightButtonFn,
        this.rightIcon,
        this.leftButtonFn,
        this.leftIcon,
        this.mainAxisAlignment = MainAxisAlignment.spaceAround})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.only(left: 32, right: 32, top: 20),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('1'),
              _calcButton('2'),
              _calcButton('3'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('4'),
              _calcButton('5'),
              _calcButton('6'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('7'),
              _calcButton('8'),
              _calcButton('9'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('*'),
              _calcButton('0'),
              InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.rightButtonFn,
                  child: Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      decoration:   BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1)
                      ),
                      child: widget.rightIcon ??   Icon(Icons.arrow_back,color: Theme.of(context).textTheme.bodyText1!.color! ,),))
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return InkWell(
        onTap: () {
          widget.onKeyboardTap(value);
        },
        child: Container(
          alignment: Alignment.center,
          decoration:   BoxDecoration(
            shape: BoxShape.circle,
            color: white
          ),
          width: 40,
          height: 40,
          child: Text(
            value,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
        ));
  }
}
