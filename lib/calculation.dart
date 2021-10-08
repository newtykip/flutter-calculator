import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'result.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  int? result;
  int? firstOperand;
  int? secondOperand;
  String? operator;
  double? width;
  double? height;

  Color operatorColour = const Color.fromRGBO(220, 220, 220, 1);

  String _getDisplayText() {
    if (result != null) {
      return '$result';
    }

    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }

    if (operator != null) {
      return '$firstOperand$operator';
    }

    if (firstOperand != null) {
      return '$firstOperand';
    }

    return '0';
  }

  Widget _getButton(
      {required String text,
      required VoidCallback onTap,
      Color backgroundColour = Colors.white,
      Color textColour = Colors.black}) {
    return CalculatorButton(
        label: text,
        onTap: onTap,
        width: (width! / 4) - 12,
        height: (height! / 4) - 12,
        backgroundColour: backgroundColour,
        labelColour: textColour);
  }

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ResultDisplay(text: _getDisplayText()),
      Row(children: [
        _getButton(text: '7', onTap: () => numberPressed(7)),
        _getButton(text: '8', onTap: () => numberPressed(8)),
        _getButton(text: '9', onTap: () => numberPressed(9)),
        _getButton(
            text: '*',
            onTap: () => operatorPressed('*'),
            backgroundColour: operatorColour)
      ]),
      Row(children: [
        _getButton(text: '4', onTap: () => numberPressed(4)),
        _getButton(text: '5', onTap: () => numberPressed(5)),
        _getButton(text: '6', onTap: () => numberPressed(6)),
        _getButton(
            text: '/',
            onTap: () => operatorPressed('/'),
            backgroundColour: operatorColour)
      ]),
      Row(children: [
        _getButton(text: '1', onTap: () => numberPressed(1)),
        _getButton(text: '2', onTap: () => numberPressed(2)),
        _getButton(text: '3', onTap: () => numberPressed(3)),
        _getButton(
            text: '+',
            onTap: () => operatorPressed('+'),
            backgroundColour: operatorColour)
      ]),
      Row(children: [
        _getButton(
            text: '=',
            onTap: calculateResult,
            backgroundColour: Colors.orange,
            textColour: Colors.white),
        _getButton(text: '0', onTap: () => numberPressed(0)),
        _getButton(text: 'C', onTap: clear, backgroundColour: operatorColour),
        _getButton(
            text: '-',
            onTap: () => operatorPressed('-'),
            backgroundColour: operatorColour)
      ])
    ]);
  }

  numberPressed(int number) {
    setState(() {
      // If the previous calculation is finished, set the result to null and set the first operand
      if (result != null) {
        result = null;
        firstOperand = number;
        return;
      }

      // If the first operand is unset, set it now
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }

      // If the operator has not been set, pressing a number will concat the number to the first operand. This allows for multi-digit operations.
      if (firstOperand != null && operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }

      // Same logic applies for the second operand
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }

      secondOperand = int.parse('$secondOperand$number');
    });
  }

  operatorPressed(String operator) {
    firstOperand ??= 0;
    this.operator = operator;
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return;
    }

    setState(() {
      switch (operator) {
        case '+':
          result = firstOperand! + secondOperand!;
          break;
        case '-':
          result = firstOperand! - secondOperand!;
          break;
        case '*':
          result = firstOperand! * secondOperand!;
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          result = firstOperand! ~/ secondOperand!;
          break;
      }

      firstOperand = result;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  clear() {
    setState(() {
      result = null;
      operator = null;
      firstOperand = null;
      secondOperand = null;
    });
  }
}
