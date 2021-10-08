import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  String text;
  final int? result;

  ResultDisplay({Key? key, required this.text, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 80,
        color: Colors.black,
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 24),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white, fontSize: 34
            )
          )
        )
      );
  }
}