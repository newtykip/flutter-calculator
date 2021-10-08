import 'package:flutter/material.dart';
import 'calculation.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Calculator', home: Scaffold(body: Calculation()));
  }
}
