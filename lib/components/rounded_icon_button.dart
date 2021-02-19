import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      child: Icon(icon,
      color: Colors.white,
      size: 30,),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 65.0,
        height: 65.0,
      ),
      shape: CircleBorder(),
      fillColor: Colors.blueGrey,
    );
  }
}