import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fruver/domain/repository/calendary_repository.dart';
import 'package:fruver/ux/const/colors.dart';
import 'package:fruver/ux/day/day_block.dart';
import 'package:fruver/ux/home/home_block.dart';
import 'package:fruver/ux/insert%20data/insert_data.dart';
import 'package:fruver/ux/widgets/card_detail.dart';
import 'package:fruver/ux/widgets/menu_date.dart';
import 'package:provider/provider.dart';

class DayScreen extends StatefulWidget {
  const DayScreen._();

  static Widget init(BuildContext context) {
    final homeBlock = Provider.of<HomeBlock>(context);
    print('${homeBlock.getDay()} day');
    return ChangeNotifierProvider<DayBlock>(
      create: (_) => DayBlock(
        homeBlock: homeBlock,
        calendaryRepository: Provider.of<CalendaryRepository>(context),
      )..initSettings(
          homeBlock.getDate(),
          homeBlock.getDay(),
          homeBlock.getMonth(),
          homeBlock.getYear(),
          homeBlock.month,
          homeBlock.monthDays,
        ),
      builder: (_, __) => const DayScreen._(),
    );
  }

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  @override
  void didUpdateWidget(covariant DayScreen oldWidget) {
    print('update');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  void a() {
    final block = Provider.of<HomeBlock>(context);
    final dayBlock = Provider.of<DayBlock>(context);
    block.setDate(DateTime(
        dayBlock.getYear(), dayBlock.getMonth(), dayBlock.getDay(), 9, 0, 0));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final homeBlock = Provider.of<HomeBlock>(context);
    final dayBlock = Provider.of<DayBlock>(context);
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: fondocontainer,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              /*child: Image.asset(           //fondo de img 
                "assets/images/fondo_verduras.jpg",
                fit: BoxFit.cover,
              ),*/
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                MenuDate(
                  onPress: callDatePicker,
                  date:
                      '${dayBlock.getDay()} de ${dayBlock.getMonths()[dayBlock.getMonth() - 1].substring(0, 3)} ${dayBlock.getYear()}',
                  backOpcion: '${dayBlock.getDayBack()}',
                  opcion: '${dayBlock.getDay()}',
                  nextOpcion: '${dayBlock.getDayNext()}',
                  flex: 4,
                  back: (dayBlock.getYear() == 2021 &&
                          dayBlock.getMonth() == 1 &&
                          dayBlock.getDay() == 1)
                      ? () {}
                      : dayBlock.backDay,
                  next: (dayBlock.getYear() == dayBlock.dateVerify.year + 1 &&
                          dayBlock.getMonth() == dayBlock.dateVerify.month &&
                          dayBlock.getDay() ==
                              dayBlock.getMonthDays()[dayBlock.getMonth() - 1])
                      ? () {}
                      : dayBlock.nextDay,
                ),
                const SizedBox(height: 10),
                CardDetails(
                  saldoInicial: (dayBlock.dataDay == null)
                      ? 0
                      : dayBlock.dataDay!.initialBalance,
                  ventas: (dayBlock.dataDay == null)
                      ? 0
                      : dayBlock.dataDay!.saleBalance,
                  gastos: (dayBlock.dataDay == null)
                      ? 0
                      : dayBlock.dataDay!.expensesBalances,
                  ganancias: (dayBlock.dataDay == null)
                      ? 0
                      : (dayBlock.dataDay!.saleBalance -
                          (dayBlock.dataDay!.initialBalance +
                              dayBlock.dataDay!.expensesBalances)),
                ),
                Expanded(
                  child: Image.asset(//imagen del logo
                      'assets/images/logotecni.png'),
                ),
                CupertinoButton(
                  child: Text(
                      (dayBlock.dataDay == null) ? 'Agregar' : 'Modificar'),
                  onPressed: () => (dayBlock.dataDay == null)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => InsertData.init(
                              context, dayBlock.getDate(), dayBlock.initdata)))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => InsertData.init1(
                              context, dayBlock.initdata, dayBlock.dataDay!))),
                  color: appcolor,
                ),
                const SizedBox(height: 60)
              ],
            ),
          ],
        ));
  }

  Future<void> callDatePicker() async {
    final dayBlock = Provider.of<DayBlock>(context, listen: false);

    final DateTime? date = await showDatePickerA();
    if (date == null) {
    } else {
      dayBlock.datePickerSelect(date);
      dayBlock.initdata();
    }
  }

  Future<DateTime?> showDatePickerA() async {
    final dayBlock = Provider.of<DayBlock>(context, listen: false);
    return showDatePicker(
        context: context,
        initialDate: dayBlock.getDate(),
        firstDate: DateTime(2021),
        lastDate: DateTime(
          dayBlock.dateVerify.year + 1,
          dayBlock.dateVerify.month,
          dayBlock.getMonthDays()[dayBlock.getMonth() - 1],
          9,
          0,
          0,
        ),
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
