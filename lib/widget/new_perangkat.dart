import 'package:flutter/material.dart';

class NewText extends StatelessWidget {
  final String text1;

  const NewText({Key? key, required this.text1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          text1,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
