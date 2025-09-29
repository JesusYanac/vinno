import 'package:flutter/material.dart';

class AtomText extends StatelessWidget {
  final String text;
  final Color? color;
  final String? family;
  final double? size;
  final FontWeight? weight;

  const AtomText({
    Key? key,
    required this.text,
    this.color,
    this.family,
    this.size,
    this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
