import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  const MyPixel({super.key, this.innercolor, this.child, this.outercolor});

  final innercolor;
  final outercolor;
  final child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(4.0),
              color: outercolor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: innercolor,
                  child: Center(
                    child: child,
                  ),
                ),
              ),
            )));
  }
}
