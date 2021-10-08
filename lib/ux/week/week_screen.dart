import 'package:flutter/material.dart';
import 'package:fruver/data/repository/calendary_repository_impl.dart';
import 'package:fruver/data/response/day_model.dart';
import 'package:fruver/domain/repository/calendary_repository.dart';
import 'package:fruver/ux/const/colors.dart';
import 'package:fruver/ux/home/home_block.dart';
import 'package:fruver/ux/insert%20data/insert_data.dart';
import 'package:fruver/ux/week/week_block.dart';
import 'package:fruver/ux/widgets/card_detail.dart';
import 'package:fruver/ux/widgets/menu_date.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeekScreen extends StatefulWidget {
  const WeekScreen._();

  static Widget init(BuildContext context) {
    final homeBlock = Provider.of<HomeBlock>(context);
    return ChangeNotifierProvider(
      create: (_) => WeekBlock(
          homeBlock: homeBlock,
          calendaryRepository: Provider.of<CalendaryRepository>(context))
        ..initSetting(
          homeBlock.month,
          homeBlock.monthDays,
          homeBlock.getDate(),
        ),
      builder: (_, __) => const WeekScreen._(),
    );
  }

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  @override
  Widget build(BuildContext context) {
    final weekBlock = Provider.of<WeekBlock>(context);
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
          /*Opacity(
            opacity: 0.9,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              // child: Image.asset(
              //   "assets/images/fondo_verduras.jpg",
              //   fit: BoxFit.cover,
              // ),
            ),
          ),*/
          Column(
            children: [
              const SizedBox(height: 20),
              MenuDate(
                onPress: callDatePicker,
                date:
                    '${weekBlock.getMonths()[weekBlock.getCurrentMonth() - 1].substring(0, 3)} ${weekBlock.getYear()}',
                backOpcion: weekBlock.getBackMonth().toString(),
                opcion: weekBlock.getCurrentMonth().toString(),
                nextOpcion: weekBlock.getNextWeek().toString(),
                flex: 4,
                back: (weekBlock.getYear() == 2021 && weekBlock.getMonth() == 1)
                    ? () {}
                    : weekBlock.backMonth,
                next: (weekBlock.getYear() == weekBlock.dateVerify.year + 1 &&
                        weekBlock.getMonth() == weekBlock.dateVerify.month)
                    ? () {}
                    : weekBlock.nextMonth,
              ),
              const SizedBox(height: 20),
              CardDetails(
                saldoInicial: (weekBlock.days == null) ? 0 : weekBlock.saldo(0),
                ventas: (weekBlock.days == null) ? 0 : weekBlock.saldo(1),
                gastos: (weekBlock.days == null) ? 0 : weekBlock.saldo(2),
                ganancias: (weekBlock.days == null) ? 0 : weekBlock.saldo(3),
              ),
              const SizedBox(height: 20),
              (weekBlock.status == false)
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : (weekBlock.days == null || weekBlock.days!.isEmpty)
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
                              print('days ${weekBlock.days!}');
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
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
                                              '${weekBlock.days![index].day} ${weekBlock.getMonths()[weekBlock.days![index].month - 1]} ${weekBlock.days![index].year}',
                                              style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              ' ${f.format(weekBlock.days![index].saleBalance - (weekBlock.days![index].initialBalance + weekBlock.days![index].expensesBalances))} ',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold),
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
                                                      color: Colors.orange[300],
                                                    ),
                                                  ),
                                                  Text(
                                                      ' ${f.format(weekBlock.days![index].initialBalance)} ')
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
                                                      color: Colors.green[300],
                                                    ),
                                                  ),
                                                  Text(
                                                      ' ${f.format(weekBlock.days![index].saleBalance)} ')
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
                                                      ' ${f.format(weekBlock.days![index].expensesBalances)} ')
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (_) =>
                                                      InsertData.init1(
                                                        _,
                                                        weekBlock.initData,
                                                        weekBlock.days![index],
                                                      ))),
                                          icon: const Icon(
                                            Icons.edit,
                                            color: primaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: weekBlock.days!.length,
                          ),
                        ),
            ],
          ),
        ],
      ),
    );
  }

  void callDatePicker() async {
    final weekBlock = Provider.of<WeekBlock>(context, listen: false);
    final DateTime? date = await showDatePickerA();
    if (date == null) {
    } else {
      weekBlock.datePickerSelect(date);
      weekBlock.initData();
    }
  }

  Future<DateTime?> showDatePickerA() async {
    final weekBlock = Provider.of<WeekBlock>(context, listen: false);

    return showDatePicker(
        context: context,
        initialDate: weekBlock.getDate(),
        firstDate: DateTime(2021),
        lastDate: DateTime(
          weekBlock.dateVerify.year + 1,
          weekBlock.dateVerify.month,
          weekBlock.getMonthsDays()[weekBlock.getCurrentMonth() - 1],
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
