import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum ButtonType { ADD_BUTTON, DELETE_BUTTON }

class AppButton extends StatelessWidget {
  final ButtonType buttonType;
  final Function onPressed;

  const AppButton(
      {Key key, @required this.buttonType, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor:
          buttonType == ButtonType.ADD_BUTTON ? Colors.greenAccent : Colors.red,
      child: Lottie.asset(
        buttonType == ButtonType.ADD_BUTTON
            ? 'assets/animations/add-new.json'
            : 'assets/animations/delete.json',
        frameRate: FrameRate(60),
      ),
    );
  }
}


