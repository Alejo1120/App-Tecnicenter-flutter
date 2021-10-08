import 'package:flutter/cupertino.dart';
import 'package:fruver/data/response/day_model.dart';
import 'package:fruver/domain/models/calendary_model.dart';
import 'package:fruver/domain/repository/calendary_repository.dart';
import 'package:intl/intl.dart';

class InsertBlock extends ChangeNotifier {
  InsertBlock({required this.calendaryRepository});
  DayModel? _day;
  late DateTime _date;
  late final VoidCallback initData;
  bool verifyCampo = false;

  final TextEditingController saldoInicial = TextEditingController();
  late final CalendaryRepository calendaryRepository;
  final TextEditingController ventas = TextEditingController();
  final TextEditingController gastos = TextEditingController();

  String saldoIC = '0.0';
  String saldoVc = '0.0';
  String saldoGC = '0.0';

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

  void verifyCampoF(bool a) {
    verifyCampo = a;
    notifyListeners();
  }

  void saldoICon() {
    saldoIC = '0.0';
    NumberFormat f = NumberFormat();
    if (saldoInicial.text != '') {
      saldoIC = f.format(int.parse(saldoInicial.text));
      notifyListeners();
    }
  }

  void saldoVCon() {
    saldoVc = '0.0';
    NumberFormat f = NumberFormat();
    if (ventas.text != '') {
      saldoVc = f.format(int.parse(ventas.text));
      notifyListeners();
    }
  }

  void saldoGCon() {
    saldoGC = '0.0';
    NumberFormat f = NumberFormat();
    if (gastos.text != '') {
      saldoGC = f.format(int.parse(gastos.text));
      notifyListeners();
    }
  }

  void initSetting(DateTime date, VoidCallback init) {
    _date = date;
    initData = init;
  }

  void initSetting2(VoidCallback init, DayModel dataDay) {
    initData = init;
    _day = DayModel(
        id: dataDay.id,
        initialBalance: dataDay.initialBalance,
        saleBalance: dataDay.saleBalance,
        expensesBalances: dataDay.expensesBalances,
        day: dataDay.day,
        month: dataDay.month,
        year: dataDay.year);

    saldoInicial.text = _day!.initialBalance.toString();
    gastos.text = _day!.expensesBalances.toString();
    ventas.text = _day!.saleBalance.toString();
  }

  Future<bool> insertData() async {
    try {
      int _saldoInicial =
          (saldoInicial.text != "0.0" && saldoInicial.text != "")
              ? int.parse(saldoInicial.text)
              : 0;
      int _saldoVentas = (ventas.text != "0.0" && ventas.text != "")
          ? int.parse(ventas.text)
          : 0;
      int _saldoGastos = (gastos.text != "0.0" && gastos.text != "")
          ? int.parse(gastos.text)
          : 0;
      CalendaryModel _ = CalendaryModel(
          initialBalance: _saldoInicial,
          saleBalance: _saldoVentas,
          expensesBalances: _saldoGastos,
          day: _date.day,
          month: _date.month,
          year: _date.year);
      await calendaryRepository.addDate(_);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateData() async {
    int _saldoInicial = (saldoInicial.text != "0.0" && saldoInicial.text != "")
        ? int.parse(saldoInicial.text)
        : 0;
    int _saldoVentas = (ventas.text != "0.0" && ventas.text != "")
        ? int.parse(ventas.text)
        : 0;
    int _saldoGastos = (gastos.text != "0.0" && gastos.text != "")
        ? int.parse(gastos.text)
        : 0;
    CalendaryModel newDay = CalendaryModel(
        initialBalance: _saldoInicial,
        saleBalance: _saldoVentas,
        expensesBalances: _saldoGastos,
        day: _day!.day,
        month: _day!.month,
        year: _day!.year);
    try {
      await calendaryRepository.updateDate(_day!.id, newDay);
      return true;
    } catch (err) {
      return false;
    }
  }

  DayModel? getDay() => _day;
  DateTime getDate() => _date;
}
