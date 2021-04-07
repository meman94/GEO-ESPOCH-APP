import 'package:flutter/material.dart';

import 'helpers.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;
  final TextDecoration decoration;

  CustomButton(
      {this.text = 'NO DEFINIDO',
      this.textColor = Colors.black,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w600,
      this.onPressed,
      this.backgroundColor = Colors.white,
      this.width = 300,
      this.height = 45,
      this.decoration = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed == null
            ? () => print('Sin métodos definidos para -> ' + text)
            : onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        child: Text(
          text,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            decoration: decoration,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: fontApp,
          ),
        ),
      ),
    );
  }
}
