import 'package:flutter/material.dart';
import 'package:fruver/ux/const/colors.dart';
import 'menu.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({this.appbar = true, Key? key}) : super(key: key);
  final bool? appbar;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      color: appcolor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Tecnicenter Villavicencio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  top: 80,
                  child: (appbar == true) ? const Menu() : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
