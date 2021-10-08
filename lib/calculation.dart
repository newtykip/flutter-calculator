import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'result.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  BigInt? result;
  BigInt? firstOperand;
  BigInt? secondOperand;
  String? operator;
  double? size;
  final int maxLength = 9;
  Color operatorColour = const Color.fromRGBO(220, 220, 220, 1);

  String _getDisplayText() {
    debugPrint('Result: $result');
    debugPrint('Operator: $operator');
    debugPrint('First Operand: $firstOperand');
    debugPrint('Second Operand: $secondOperand');

    if (result != null) {
      var divisionCount = 0;

      while (result.toString().length > maxLength) {
        result = BigInt.from(result! / BigInt.from(10));
        divisionCount++;
      }

      return '${result}e+$divisionCount';
    }

    if (secondOperand != null) {
      return secondOperand.toString();
    }

    if (firstOperand != null) {
      return firstOperand.toString();
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
        size: size! / 2.5,
        backgroundColour: backgroundColour,
        labelColour: textColour);
  }

  @override
  void didChangeDependencies() {
    var q = MediaQuery.of(context).size;
    size = q.width > q.height ? q.width : q.height;
    size = size! / 5;
    debugPrint('Size: $size');
    debugPrint('Dimensions: ${q.width}x${q.height}');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ResultDisplay(text: _getDisplayText()),
      Padding(
          padding:
              EdgeInsets.only(top: (size! / 4) / 2, bottom: (size! / 4) / 2)),
      Row(children: [
        _getButton(text: '7', onTap: () => numberPressed(7)),
        _getButton(text: '8', onTap: () => numberPressed(8)),
        _getButton(text: '9', onTap: () => numberPressed(9)),
        _getButton(
            text: 'x',
            onTap: () => operatorPressed('*'),
            backgroundColour: operatorColour)
      ], mainAxisAlignment: MainAxisAlignment.center),
      Row(children: [
        _getButton(text: '4', onTap: () => numberPressed(4)),
        _getButton(text: '5', onTap: () => numberPressed(5)),
        _getButton(text: '6', onTap: () => numberPressed(6)),
        _getButton(
            text: '/',
            onTap: () => operatorPressed('/'),
            backgroundColour: operatorColour)
      ], mainAxisAlignment: MainAxisAlignment.center),
      Row(children: [
        _getButton(text: '1', onTap: () => numberPressed(1)),
        _getButton(text: '2', onTap: () => numberPressed(2)),
        _getButton(text: '3', onTap: () => numberPressed(3)),
        _getButton(
            text: '+',
            onTap: () => operatorPressed('+'),
            backgroundColour: operatorColour)
      ], mainAxisAlignment: MainAxisAlignment.center),
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
      ], mainAxisAlignment: MainAxisAlignment.center)
    ]);
  }

  numberPressed(int n) {
    var number = BigInt.from(n);

    setState(() {
      // If the first operand is unset, set it now
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }

      // Cap the first operand at the max length
      if (firstOperand.toString().length >= maxLength && operator == null) {
        return;
      }

      // If the operator has not been set, pressing a number will concat the number to the first operand. This allows for multi-digit operations.
      if (firstOperand != null && operator == null) {
        firstOperand = BigInt.parse('$firstOperand$number');
        return;
      }

      // Same logic applies for the second operand
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }

      if (secondOperand.toString().length >= maxLength) {
        return;
      }

      secondOperand = BigInt.parse('$secondOperand$number');
    });
  }

  operatorPressed(String op) {
    firstOperand ??= BigInt.from(0);
    operator = op;
  }

  calculateResult() {
    if (firstOperand == null || operator == null || secondOperand == null) {
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
          if (secondOperand == BigInt.from(0)) {
            return;
          }
          result = firstOperand! ~/ secondOperand!;
          break;
      }

      firstOperand = null;
      operator = null;
      secondOperand = null;
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
