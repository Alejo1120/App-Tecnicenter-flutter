import 'package:flutter/material.dart';
import 'package:fruver/data/response/day_model.dart';
import 'package:fruver/domain/repository/calendary_repository.dart';
import 'package:fruver/ux/home/home_block.dart';

class DayBlock extends ChangeNotifier {
  late final HomeBlock homeBlock;
  late final CalendaryRepository calendaryRepository;
  DayModel? dataDay;

  DayBlock({
    required this.calendaryRepository,
    required this.homeBlock,
  });

  int _dayBack = 0;
  int _currenDay = 0;
  int _nextDay = 0;
  int _month = 0;
  int _year = 0;
  late DateTime _date;
  late final DateTime dateVerify = DateTime.now();
  late final List<String> _months;
  late final List<int> _monthDays;

  void initSettings(
    DateTime date,
    int day,
    int month,
    int year,
    List<String> mounts,
    List<int> monthDays,
  ) {
    print(month);
    if (day == 1) {
      _dayBack = monthDays[(month == 1) ? 11 : month - 1];
    } else if (day == monthDays[month - 1]) {
      _nextDay = 1;
    }
    _months = mounts;
    _monthDays = monthDays;
    _date = date;
    _currenDay = day;
    _month = month;
    _year = year;
    _dayBack = selectDayBack(day);
    _nextDay = selectNextDay(day);
    initdata();
  }

  void initdata() async {
    dataDay = null;
    print('initdata');
    late final DayModel _day;
    try {
      _day = await calendaryRepository.getDay(_date);
      dataDay = DayModel(
          id: _day.id,
          initialBalance: _day.initialBalance,
          saleBalance: _day.saleBalance,
          expensesBalances: _day.expensesBalances,
          day: _day.day,
          month: _day.month,
          year: _day.year);
      notifyListeners();
    } catch (err) {
      Exception();
    }
  }

  void datePickerSelect(DateTime date) {
    print('$date date ');
    (date.year % 4 == 0) ? _monthDays[1] = 29 : _monthDays[1] = 28;
    if (date.day == 1) {
      _dayBack = _monthDays[(date.month == 1) ? 11 : date.month - 1];
    } else if (date.day == _monthDays[date.month - 1]) {
      _nextDay = 1;
    }
    _date = date;
    _currenDay = date.day;
    _month = date.month;
    _year = date.year;
    _dayBack = selectDayBack(date.day);
    _nextDay = selectNextDay(date.day);
    updateDate();
    notifyListeners();
  }

  int selectDayBack(int day) {
    if (day == 1) {
      if (_month == 1) {
        return _monthDays[0];
      } else {
        return _monthDays[_month - 2];
      }
    } else {
      return day -= 1;
    }
  }

  int selectNextDay(int day) {
    if (day == _monthDays[_month - 1]) {
      return 1;
    } else {
      return day += 1;
    }
  }

  void backDay() {
    if (_currenDay == 1) {
      if (_month == 1) {
        _month = 12;
        _year--;
        (_year % 4 == 0) ? _monthDays[1] = 29 : _monthDays[1] = 28;
        homeBlock.monthDays[1] = _monthDays[1];
        _currenDay = _monthDays[_month - 1];
        _nextDay = 1;
        _dayBack = _monthDays[_month - 1] - 1;
      } else {
        _month--;
        _currenDay = _monthDays[_month - 1];
        _nextDay = 1;
        _dayBack = _monthDays[_month - 1] - 1;
      }
    } else if (_currenDay == 2) {
      if (_month == 1) {
        _currenDay--;
        _nextDay--;
        _dayBack = _monthDays[11];
      } else {
        _currenDay--;
        _nextDay--;
        _dayBack = _monthDays[_month - 2];
      }
    } else if (_currenDay == _monthDays[_month - 1]) {
      _currenDay--;
      _nextDay = _monthDays[_month - 1];
      _dayBack--;
    } else {
      _dayBack--;
      _currenDay--;
      _nextDay--;
    }
    updateDate();
    initdata();
    notifyListeners();
  }

  void nextDay() {
    if (_currenDay == _monthDays[_month - 1]) {
      if (_month == 12) {
        _month = 1;
        _year++;
        (_year % 4 == 0) ? _monthDays[1] = 29 : _monthDays[1] = 28;
        homeBlock.monthDays[1] = _monthDays[1];
        _dayBack = _monthDays[11];
        _currenDay = 1;
        _nextDay = 2;
      } else {
        _dayBack++;
        _currenDay = 1;
        _nextDay = 2;
        _month++;
      }
    } else if (_currenDay == _monthDays[_month - 1] - 1) {
      _dayBack++;
      _currenDay++;
      _nextDay = 1;
    } else if (_currenDay == 1) {
      _dayBack = 1;
      _currenDay++;
      _nextDay++;
    } else {
      _dayBack++;
      _currenDay++;
      _nextDay++;
    }
    updateDate();
    notifyListeners();
    initdata();
  }

  void updateDate() {
    _date = DateTime(_year, _month, _currenDay, 9, 0, 0);
    homeBlock.setDay(_currenDay);
    homeBlock.setMonth(_month);
    homeBlock.setYear(_year);
    homeBlock.setDate(_date);
  }

  DateTime getDate() => _date;
  int getDayBack() => _dayBack;
  int getDay() => _currenDay;
  int getDayNext() => _nextDay;
  int getMonth() => _month;
  int getYear() => _year;
  List<String> getMonths() => _months;
  List<int> getMonthDays() => _monthDays;

  void setDayBack(int day) {
    _dayBack = day;
    notifyListeners();
  }
}
