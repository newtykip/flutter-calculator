import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'result.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  int result = 0;
  Color operatorColour = const Color.fromRGBO(220, 220, 220, 1);

  Widget _getButton(
      {required String text,
      required VoidCallback onTap,
      Color backgroundColour = Colors.white,
      Color textColour = Colors.black}) {
    return CalculatorButton(
        label: text,
        onTap: onTap,
        size: 90,
        backgroundColour: backgroundColour,
        labelColour: textColour);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ResultDisplay(text: result.toString()),
      Row(children: [
        _getButton(text: '7', onTap: () => numberPressed(7)),
        _getButton(text: '8', onTap: () => numberPressed(8)),
        _getButton(text: '9', onTap: () => numberPressed(9)),
        _getButton(text: '*', onTap: () => operatorPressed('*'), backgroundColour: operatorColour)
      ]),
      Row(children: [
        _getButton(text: '4', onTap: () => numberPressed(4)),
        _getButton(text: '5', onTap: () => numberPressed(5)),
        _getButton(text: '6', onTap: () => numberPressed(6)),
        _getButton(text: '/', onTap: () => operatorPressed('/'), backgroundColour: operatorColour)
      ]),
      Row(children: [
        _getButton(text: '1', onTap: () => numberPressed(1)),
        _getButton(text: '2', onTap: () => numberPressed(2)),
        _getButton(text: '3', onTap: () => numberPressed(3)),
        _getButton(text: '+', onTap: () => operatorPressed('+'), backgroundColour: operatorColour)
      ]),
      Row(children: [
        _getButton(text: '=', onTap: calculateResult, backgroundColour: Colors.orange, textColour: Colors.white),
        _getButton(text: '0', onTap: () => numberPressed(0)),
        _getButton(text: 'C', onTap: clear, backgroundColour: operatorColour),
        _getButton(text: '-', onTap: () => operatorPressed('-'), backgroundColour: operatorColour)
      ])
    ]);
  }

  operatorPressed(String operator) {}
  numberPressed(int number) {}
  calculateResult() {}
  clear() {}
}
