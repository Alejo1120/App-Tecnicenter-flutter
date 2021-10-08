import 'package:flutter/material.dart';
import 'package:fruver/domain/repository/calendary_repository.dart';
import 'package:fruver/ux/const/colors.dart';
import 'package:fruver/ux/home/home_block.dart';
import 'package:fruver/ux/widgets/card_detail.dart';
import 'package:fruver/ux/widgets/menu_date.dart';
import 'package:fruver/ux/year/year_block.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class YearScreen extends StatefulWidget {
  const YearScreen._();

  static Widget init(BuildContext context) {
    final homeBlock = Provider.of<HomeBlock>(context);
    return ChangeNotifierProvider(
      create: (_) => YearBlock(
        homeBlock: homeBlock,
        calendaryRepository: Provider.of<CalendaryRepository>(context),
      )..initSetting(
          homeBlock.getDate(),
          homeBlock.monthDays,
        ),
      builder: (_, __) => const YearScreen._(),
    );
  }

  @override
  State<YearScreen> createState() => _YearScreenState();
}

class _YearScreenState extends State<YearScreen> {
  @override
  Widget build(BuildContext context) {
    final yearBlock = Provider.of<YearBlock>(context);
    final NumberFormat f = NumberFormat();
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
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              /*child: Image.asset(
                "assets/images/fondo_verduras.jpg",
                fit: BoxFit.cover,
              ),*/
            ),
            Column(
              children: [
                const SizedBox(height: 20),
                MenuDate(
                  onPress: callDatePicker,
                  date: yearBlock.getCurrentYear().toString(),
                  backOpcion: yearBlock.getBackYear().toString(),
                  opcion: yearBlock.getCurrentYear().toString(),
                  nextOpcion: yearBlock.getNextYear().toString(),
                  flex: 6,
                  back:
                      (yearBlock.getCurrentYear() == yearBlock.dateVerify.year)
                          ? () {}
                          : yearBlock.backYear,
                  next: (yearBlock.getCurrentYear() ==
                          yearBlock.dateVerify.year + 1)
                      ? () {}
                      : yearBlock.nextYear,
                ),
                const SizedBox(height: 20),
                CardDetails(
                  // ignore: unnecessary_null_comparison
                  saldoInicial:
                      (yearBlock.year.isEmpty) ? 0 : yearBlock.saldoInicialF,
                  ventas: (yearBlock.year.isEmpty) ? 0 : yearBlock.saldoventasF,
                  gastos: (yearBlock.year.isEmpty) ? 0 : yearBlock.saldogastosF,
                  ganancias:
                      (yearBlock.year.isEmpty) ? 0 : yearBlock.gananciasF,
                ),
                (yearBlock.status == false)
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : (yearBlock.year == null || yearBlock.year.isEmpty)
                        ? Expanded(
                            child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/extraviado.png',
                                  width: 150,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'No hay registros',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ))
                        : Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Ganancias',
                                                style: TextStyle(
                                                  fontSize: 19,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                '${yearBlock.month[yearBlock.year[index].month - 1]} ${yearBlock.year[index].year}',
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                ' ${f.format(yearBlock.year[index].saldoGanancias)} ',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Colors.orange[300],
                                                      ),
                                                    ),
                                                    Text(
                                                        ' ${f.format(yearBlock.year[index].saldoInicial)} ')
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Colors.green[300],
                                                      ),
                                                    ),
                                                    Text(
                                                        ' ${f.format(yearBlock.year[index].saldoVentas)} ')
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red[300],
                                                      ),
                                                    ),
                                                    Text(
                                                        ' ${f.format(yearBlock.year[index].saldoGastos)} ')
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: yearBlock.year.length,
                            ),
                          ),
              ],
            ),
          ],
        ));
  }

  void callDatePicker() async {
    final yearBlock = Provider.of<YearBlock>(context, listen: false);
    final DateTime? date = await showDatePickerA();
    if (date == null) {
    } else {
      yearBlock.datePickerSelect(date);
      yearBlock.initData();
    }
  }

  Future<DateTime?> showDatePickerA() async {
    final yearBlock = Provider.of<YearBlock>(context, listen: false);
    return showDatePicker(
        context: context,
        initialDate: yearBlock.getDate(),
        firstDate: DateTime(2021),
        lastDate: DateTime(
          yearBlock.dateVerify.year + 1,
          yearBlock.dateVerify.month,
          yearBlock.getMonthsDay()[yearBlock.getMonth() - 1],
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
