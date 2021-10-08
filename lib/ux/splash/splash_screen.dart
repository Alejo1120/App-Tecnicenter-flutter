import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruver/ux/const/colors.dart';
import 'package:fruver/ux/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animationController.repeat(reverse: true);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF212226),
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xFF212226),
    ));

    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomeScreen.init(_),
        ),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    //s_animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212226),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, snapshot) {
                final newValue =
                    lerpDouble(0.5, 1, _animationController.value)!;
                return Transform(
                  transform: Matrix4.identity()..scale(newValue),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 300,
                    height: 150,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logotecni.png', //img de carga
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
