import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fruver/ux/const/colors.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: appcolor,
          ),
          child
        ],
      ),
    );
  }
}
