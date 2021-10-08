import 'package:flutter/material.dart';
import 'package:fruver/ux/const/colors.dart';
import 'package:fruver/ux/widgets/card_detail.dart';
import 'package:fruver/ux/widgets/menu_date.dart';

class MonthScreen extends StatefulWidget {
  const MonthScreen({Key? key}) : super(key: key);

  @override
  State<MonthScreen> createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: fondocontainer,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            MenuDate(
              onPress: callDatePicker,
              date: '1 de nov 2021',
              backOpcion: '1',
              opcion: '2',
              nextOpcion: '3',
              flex: 1,
              back: () {},
              next: () {},
            ),
            const SizedBox(height: 20),
            const CardDetails(
              saldoInicial: 0,
              ventas: 0,
              gastos: 0,
              ganancias: 0,
            ),
          ],
        ));
  }

  void callDatePicker() async {
    await showDatePickerA();
  }

  Future<DateTime?> showDatePickerA() async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2021, 10, 20),
        initialDatePickerMode: DatePickerMode.day,
        builder: (_, __) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme:
                  const ColorScheme.light().copyWith(primary: primaryColor),
            ),
            child: __!,
          );
        },
        cancelText: 'Cancelar',
        confirmText: 'Seleccionar');
  }
}
