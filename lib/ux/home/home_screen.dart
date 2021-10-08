import 'package:flutter/material.dart';
import 'package:fruver/ux/home/home_block.dart';
import 'package:fruver/ux/screens.dart';
import 'package:fruver/ux/widgets/app_bar.dart';
import 'package:fruver/ux/widgets/background.dart';
import 'package:fruver/ux/widgets/menu.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider<HomeBlock>(
      create: (_) => HomeBlock()..initSetting(),
      builder: (_, __) => const HomeScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final block = Provider.of<HomeBlock>(context);
    return SafeArea(
        child: Scaffold(
      body: Background(
        child: Column(
          children: [
            Stack(
              children: const [
                AppBarCustom(),
              ],
            ),
            Expanded(
              child: PageView(
                controller: block.pageController,
                physics: const BouncingScrollPhysics(),
                children: [
                  DayScreen.init(context),
                  WeekScreen.init(context),
                  YearScreen.init(context),
                ],
                onPageChanged: (_) {
                  block.setIndexPage(_);
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
