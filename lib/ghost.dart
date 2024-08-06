import 'package:flutter/material.dart';

class Ghost extends StatelessWidget {
  const Ghost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(2.0),
      child: Image.asset("lib/image/ghost.png"),
    );
  }
}