import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'result.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  int result = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResultDisplay(text: result.toString()),
        Row(
          children: [
            CalculatorButton(
              label: '7',
              onTap: () => {},
              size: 90,
              backgroundColor: Colors.white,
              labelColor: Colors.black,
            )
          ]
        )
      ]
    );
  }
}
