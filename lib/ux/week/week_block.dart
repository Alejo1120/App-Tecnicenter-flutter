import 'package:flutter/cupertino.dart';
import 'package:fruver/data/response/day_model.dart';
import 'package:fruver/domain/repository/calendary_repository.dart';
import 'package:fruver/ux/home/home_block.dart';

class WeekBlock extends ChangeNotifier {
  WeekBlock({required this.homeBlock, required this.calendaryRepository});
  late final HomeBlock homeBlock;
  late final CalendaryRepository calendaryRepository;
  late final List<String> _months;
  late final List<int> _monthsDays;
  late final DateTime dateVerify = DateTime.now();
  List<DayModel>? days;
  bool status = false;

  late DateTime _date;
  int _day = 0;
  int _backMonth = 0;
  int _currentMonth = 0;
  int _nextMont = 0;
  int _year = 0;

  void initSetting(List<String> months, List<int> monthsDays, DateTime date) {
    _months = months;
    _monthsDays = monthsDays;
    _date = date;
    _day = date.day;
    _year = date.year;
    datePickerSelect(date);
    initData();
  }

  void initData() async {
    days = null;
    late final List<DayModel> _day;

    try {
      _day = await calendaryRepository.getDaysMonth(
          _year.toString(), _currentMonth.toString());
      days = List.generate(
          _day.length,
          (i) => DayModel(
              id: _day[i].id,
              initialBalance: _day[i].initialBalance,
              saleBalance: _day[i].saleBalance,
              expensesBalances: _day[i].expensesBalances,
              day: _day[i].day,
              month: _day[i].month,
              year: _day[i].year));
      status = true;
      notifyListeners();
    } catch (err) {
      days = null;
      status = false;
      notifyListeners();
      throw Exception();
    }
  }

  int saldo(int i) {
    int saldo = 0;
    switch (i) {
      case 0:
        for (int i = 0; i < days!.length; i++) {
          saldo += days![i].initialBalance;
        }
        break;
      case 1:
        for (int i = 0; i < days!.length; i++) {
          saldo += days![i].saleBalance;
        }

        break;
      case 2:
        for (int i = 0; i < days!.length; i++) {
          saldo += days![i].expensesBalances;
        }
        break;
      case 3:
        int ventas = 0;
        int saldoInicial = 0;
        int gasto = 0;
        for (int i = 0; i < days!.length; i++) {
          saldoInicial += days![i].initialBalance;
          ventas += days![i].saleBalance;
          gasto += days![i].expensesBalances;
        }
        saldo = ventas - (gasto + saldoInicial);
        break;
    }
    return saldo;
  }

  void backMonth() {
    if (_currentMonth == 1) {
      _year--;
      (_year % 4 == 0)
          ? homeBlock.monthDays[1] = 29
          : homeBlock.monthDays[1] = 28;
      _currentMonth = 12;
      _backMonth = _currentMonth - 1;
      _nextMont = 1;
    } else if (_currentMonth == 12) {
      _backMonth--;
      _currentMonth--;
      _nextMont = 12;
    } else if (_currentMonth == 2) {
      _backMonth = 12;
      _currentMonth--;
      _nextMont--;
    } else {
      _backMonth--;
      _currentMonth--;
      _nextMont--;
    }
    updateDate(true);
    initData();
    notifyListeners();
  }

  void nextMonth() {
    if (_currentMonth == 11) {
      //_year++;
      (_year % 4 == 0)
          ? homeBlock.monthDays[1] = 29
          : homeBlock.monthDays[1] = 28;
      _currentMonth++;
      _backMonth++;
      _nextMont = 1;
    } else if (_currentMonth == 12) {
      print('aumento del ano');
      _backMonth++;
      _currentMonth = 1;
      _nextMont = _currentMonth + 1;
      _year++;
    } else if (_currentMonth == 1) {
      _backMonth = 1;
      _currentMonth++;
      _nextMont++;
    } else if (_currentMonth == 2) {
      _backMonth++;
      _currentMonth++;
      _nextMont++;
    } else {
      _backMonth++;
      _currentMonth++;
      _nextMont++;
    }
    updateDate(true);
    initData();
    notifyListeners();
  }

  void datePickerSelect(DateTime date) {
    _currentMonth = date.month;
    if (date.month == 1) {
      _backMonth = 12;
      _nextMont += _currentMonth + 1;
    } else if (date.month == 12) {
      _backMonth = 11;
      _nextMont = 1;
    } else {
      _backMonth = date.month - 1;
      _nextMont = _currentMonth + 1;
    }
    _day = date.day;
    _year = date.year;

    updateDate(false);
    initData();
    notifyListeners();
  }

  void updateDate(bool a) {
    if (a == true) {
      if (homeBlock.monthDays[(_currentMonth == 1) ? 11 : _currentMonth - 2] >
          _day) {
        homeBlock.setDay(1);
      }else{
        homeBlock.setDay(_day);

      }
    } else {
      homeBlock.setDay(_day);
    }
    _date = DateTime(_year, _currentMonth, _day, 9, 0, 0);
    homeBlock.setMonth(_currentMonth);
    homeBlock.setYear(_year);
    homeBlock.setDate(_date);
  }

  void setMonths(List<String> months) {
    _months = months;
  }

  int getBackMonth() => _backMonth;
  int getCurrentMonth() => _currentMonth;
  int getNextWeek() => _nextMont;
  DateTime getDate() => _date;
  int getDay() => _day;
  int getMonth() => _currentMonth;
  int getYear() => _year;
  List<String> getMonths() => _months;
  List<int> getMonthsDays() => _monthsDays;
}
