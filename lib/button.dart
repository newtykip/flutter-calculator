import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  CalculatorButton(
      {required this.label,
      required this.onTap,
      required this.size,
      this.backgroundColour = Colors.white,
      this.labelColour = Colors.black});

  final String label;
  final VoidCallback onTap;
  final double size;
  final Color backgroundColour;
  final Color labelColour;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(6),
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(1, 1), blurRadius: 2),
              ],
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
              color: backgroundColour),
          child: InkWell(
              customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(size / 2))),
              onTap: onTap,
              child: Center(
                  child: Text(label,
                      style: TextStyle(fontSize: 24, color: labelColour)))),
        ));
  }
}
