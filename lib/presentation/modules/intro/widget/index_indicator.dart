import 'package:flutter/material.dart';

class IndexIndicator extends StatelessWidget {
  final double? width;
  final Color? color;
  const IndexIndicator({Key? key, this.width, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width, height: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        shape: BoxShape.rectangle,
        color: color,
      ),
    );
  }
}
