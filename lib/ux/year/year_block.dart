import 'package:flutter/widgets.dart';
import 'package:fruver/data/response/day_model.dart';
import 'package:fruver/domain/models/year_model.dart';
import 'package:fruver/domain/repository/calendary_repository.dart';
import 'package:fruver/ux/home/home_block.dart';

class YearBlock extends ChangeNotifier {
  YearBlock({required this.homeBlock, required this.calendaryRepository});
  late final HomeBlock homeBlock;
  late final CalendaryRepository calendaryRepository;
  late DateTime _date;
  late final List<int> _monthsDays;
  List<DayModel>? days;
  bool status = false;
  List<YearModel> year = [];
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

  int saldoInicialF = 0;
  int saldoventasF = 0;
  int saldogastosF = 0;
  int gananciasF = 0;
  late final DateTime dateVerify = DateTime.now();

  int _day = 0;
  int _month = 0;
  int _backYear = 0;
  int _currentYear = 0;
  int _nextYear = 0;

  void initSetting(DateTime date, List<int> monthsDay) {
    _backYear = date.year - 1;
    _currentYear = date.year;
    _nextYear = _currentYear + 1;
    _day = date.day;
    _month = date.month;
    _date = date;
    _monthsDays = monthsDay;
    initData();
  }

  void initData() async {
    days = null;
    late final List<DayModel> _day;
    List<YearModel>? _year = [];
    year = [];


    int montcurrent = 0;
    int anocurrent = 0;

    int saldoInicial = 0;
    int saldoventas = 0;
    int saldogastos = 0;
    int ganancias = 0;

    saldoInicialF = 0;
    saldoventasF = 0;
    saldogastosF = 0;
    gananciasF = 0;

    try {
      _day = await calendaryRepository.getDaysYear(_currentYear.toString());
      if (_day.length > 1) {
        print('lista llena');
        for (int i = 0; i < _day.length; i++) {
          print('kakakakk $i -------${_day.length}');
          print('i  for $montcurrent');

          print('lalala ${_day[i].day}');
          if (i == 0) {
            montcurrent = _day[i].month;
            print('i 0 $montcurrent');
          }
          if (_day[i].month == montcurrent) {
            saldoInicial += _day[i].initialBalance;
            saldoventas += _day[i].saleBalance;
            saldogastos += _day[i].expensesBalances;
            montcurrent = _day[i].month;
          } else {
            ganancias = (saldoventas - (saldogastos + saldoInicial));
            YearModel y = YearModel(
                year: _day[i - 1].year,
                month: _day[i - 1].month,
                saldoInicial: saldoInicial,
                saldoVentas: saldoventas,
                saldoGastos: saldogastos,
                saldoGanancias: ganancias);
            _year.add(y);
            saldoInicial = 0;
            saldoventas = 0;
            saldogastos = 0;
            ganancias = 0;
            saldoInicial += _day[i].initialBalance;
            saldoventas += _day[i].saleBalance;
            saldogastos += _day[i].expensesBalances;
            montcurrent = _day[i].month;
          }

          if (i == _day.length - 1) {
            print(' i = leng');
            ganancias = (saldoventas - (saldogastos + saldoInicial));

            YearModel y = YearModel(
                year: _day[i].year,
                month: _day[i].month,
                saldoInicial: saldoInicial,
                saldoVentas: saldoventas,
                saldoGastos: saldogastos,
                saldoGanancias: ganancias);
            _year.add(y);
          }
        }

        year = List.generate(
          _year.length,
          (index) => YearModel(
              year: _year[index].year,
              month: _year[index].month,
              saldoInicial: _year[index].saldoInicial,
              saldoVentas: _year[index].saldoVentas,
              saldoGastos: _year[index].saldoGastos,
              saldoGanancias: _year[index].saldoGanancias),
        );
      } else if (_day.length == 1) {
        year = List.generate(
          _day.length,
          (index) => YearModel(
              year: _day[index].year,
              month: _day[index].month,
              saldoInicial: _day[index].initialBalance,
              saldoVentas: _day[index].saleBalance,
              saldoGastos: _day[index].expensesBalances,
              saldoGanancias: (_day[index].saleBalance -
                  (_day[index].initialBalance + _day[index].expensesBalances))),
        );
      }
      for (int i = 0; i < year.length; i++) {
        gananciasF += (year[i].saldoVentas -
            (year[i].saldoInicial + year[i].saldoGastos));
        saldoInicialF += year[i].saldoInicial;
        saldoventasF += year[i].saldoVentas;
        saldogastosF += year[i].saldoGastos;
      }
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

  void backYear() {
    _backYear--;
    _currentYear--;
    _nextYear--;
    updateDate(true);
    initData();
    notifyListeners();
  }

  void nextYear() {
    _backYear++;
    _currentYear++;
    _nextYear++;
    updateDate(true);
    initData();
    notifyListeners();
  }

  void datePickerSelect(DateTime date) {
    _day = date.day;
    _month = date.month;
    _backYear = date.year - 1;
    _currentYear = date.year;
    _nextYear = _currentYear + 1;
    updateDate(false);
    notifyListeners();
  }

  void updateDate(bool a) {
    if (a == true) {
      if (homeBlock.monthDays[(_month == 1) ? 11 : _month - 1] > _day) {
        homeBlock.setDay(1);
      }
    } else {
      homeBlock.setDay(_day);
    }
    _date = DateTime(_currentYear, _month, _day, 9, 0, 0);
    homeBlock.setMonth(_month);
    homeBlock.setYear(_currentYear);
    homeBlock.setDate(_date);
  }

  int getMonth() => _month;
  int getBackYear() => _backYear;
  int getCurrentYear() => _currentYear;
  int getNextYear() => _nextYear;
  DateTime getDate() => _date;
  List<int> getMonthsDay() => _monthsDays;
  int getSaldoI() => saldoInicialF;
}
