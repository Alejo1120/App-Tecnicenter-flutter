import 'package:flutter/material.dart';

class HomeBlock extends ChangeNotifier {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  int indexPage = 0;

  late DateTime _currentDate;
  int _day = 0;
  int _year = 0;
  int _month = 0;
  final List<String> month = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];
  late final List<int> monthDays;

  void initSetting() {
    _currentDate = DateTime.now();
    _day = _currentDate.day;
    _month = _currentDate.month;
    _year = _currentDate.year;
    monthDays = [
      31,
      (verifyYear(getYear()) == true) ? 29 : 28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31,
    ];
  }

  bool verifyYear(int year) {
    if (year % 4 == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> setIndexPage(int index) async {
    if (indexPage == 0) {
      if (index == 1) {
        await pageController.animateToPage(index,
            curve: Curves.linear, duration: const Duration(milliseconds: 200));
        indexPage = index;
      } else {
        Future.delayed(const Duration(milliseconds: 300), () {
          pageController.jumpToPage(index);
          indexPage = index;
        });
      }
    } else {
      int valor = index - indexPage;
      if (valor.abs() == 1) {
        await pageController.animateToPage(index,
            curve: Curves.linear, duration: const Duration(milliseconds: 200));
        indexPage = index;
      } else {
        Future.delayed(const Duration(milliseconds: 300), () {
          pageController.jumpToPage(index);
          indexPage = index;
        });
      }
    }
    notifyListeners();
  }

  void setDate(DateTime date) {
    _currentDate = date;
  }

  void setDay(int day) {
    _day = day;
  }

  void setMonth(int mount) {
    _month = mount;
  }

  void setYear(int year) {
    _year = year;
  }

  DateTime getDate() => _currentDate;
  int getDay() => _day;
  int getMonth() => _month;
  int getYear() => _year;
}
