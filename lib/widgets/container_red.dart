import 'package:flutter/material.dart';

class ContainerRed extends StatelessWidget {
  const ContainerRed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 100,
    );
  }
}
