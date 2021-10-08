import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruver/data/response/day_model.dart';
import 'package:fruver/domain/repository/calendary_repository.dart';
import 'package:fruver/ux/const/colors.dart';
import 'package:fruver/ux/day/day_block.dart';
import 'package:fruver/ux/insert%20data/insert_block.dart';
import 'package:fruver/ux/widgets/app_bar.dart';
import 'package:fruver/ux/widgets/background.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InsertData extends StatefulWidget {
  const InsertData._();

  static Widget init(
      BuildContext context, DateTime date, VoidCallback initData) {
    Provider.of<DayBlock>(context);
    return ChangeNotifierProvider(
      create: (_) => InsertBlock(
        calendaryRepository: Provider.of<CalendaryRepository>(context),
      )..initSetting(date, initData),
      builder: (_, __) => InsertData._(),
    );
  }

  static Widget init1(
      BuildContext context, VoidCallback initData, DayModel day) {
    return ChangeNotifierProvider(
      create: (_) => InsertBlock(
        calendaryRepository: Provider.of<CalendaryRepository>(context),
      )..initSetting2(initData, day),
      builder: (_, __) => InsertData._(),
    );
  }

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  void senData() async {
    final block = Provider.of<InsertBlock>(context, listen: false);
    bool res = await block.insertData();
    if (res == true) {
      block.initData();
      Navigator.of(context).pop();
    } else {
      block.verifyCampoF(true);
      Future.delayed(Duration(seconds: 1), () {
        block.verifyCampoF(false);
      });
    }
  }

  void updateData() async {
    final block = Provider.of<InsertBlock>(context, listen: false);
    final res = await block.updateData();
    if (res == true) {
      block.initData();
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final block = Provider.of<InsertBlock>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    final height = size.height - 90;
    return SafeArea(
        child: Scaffold(
      body: Background(
        child: Column(
          children: [
            const AppBarCustom(
              appbar: false,
            ),
            const SizedBox(height: 20),
            Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  block.saldoGCon();
                  block.saldoVCon();
                  block.saldoICon();
                },
                child: Container(
                  width: double.infinity,
                  height: height,
                  decoration: const BoxDecoration(
                    color: fondocontainer,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(Icons.close_rounded),
                              iconSize: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          (block.getDay() == null)
                              ? ' ${block.getDate().day} ${block.month[block.getDate().month - 1]} ${block.getDate().year}'
                              : ' ${block.getDay()!.day} ${block.month[block.getDay()!.month - 1]} ${block.getDay()!.year} ',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        /* Expanded(
                          /* child: SvgPicture.asset(
                          'assets/images/money.svg',
                          color: primaryColor,
                          width: 150,
                        )*/
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 200,
                          ),
                        ),*/
                        const SizedBox(height: 20),
                        InputCustom(
                          controller: block.saldoInicial,
                          label: 'Saldo inicial',
                          labelBottom: 'Saldo',
                          color: Colors.yellow[300],
                          conver: block.saldoICon,
                          saldo: block.saldoIC,
                        ),
                        const SizedBox(height: 20),
                        InputCustom(
                          controller: block.ventas,
                          label: 'Saldo ventas',
                          labelBottom: 'Saldo',
                          color: Colors.green[300],
                          conver: block.saldoVCon,
                          saldo: block.saldoVc,
                        ),
                        const SizedBox(height: 20),
                        InputCustom(
                          controller: block.gastos,
                          label: 'Saldo Gastos',
                          labelBottom: 'Saldo',
                          color: Colors.red[300],
                          conver: block.saldoGCon,
                          saldo: block.saldoGC,
                        ),
                        const SizedBox(height: 40),
                        CupertinoButton(
                          color: primaryColor,
                          child: Text(
                            (block.getDay() == null) ? 'Agregar' : 'Modificar',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => (block.getDay() == null)
                              ? senData()
                              : updateData(),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
            )),
            Consumer<InsertBlock>(
              builder: (_, __, ___) {
                return (__.verifyCampo == true)
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 10),
                        width: double.infinity,
                        height: 30,
                        color: primaryColor,
                        child: Text(
                          'Ingrese todos los campos',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Container();
              },
            )
          ],
        ),
      ),
    ));
  }
}

class InputCustom extends StatelessWidget {
  const InputCustom({
    Key? key,
    required this.controller,
    required this.label,
    required this.labelBottom,
    required this.saldo,
    required this.color,
    required this.conver,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String labelBottom;
  final String saldo;
  final Color? color;
  final VoidCallback conver;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: 80,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              blurRadius: 0.5,
              color: primaryColor,
              spreadRadius: 0.5,
              offset: Offset(0, 0))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.monetization_on_outlined,
                    color: color,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      enableInteractiveSelection: false,
                      onChanged: (valor) {},
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        conver();
                      },
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                      showCursor: false,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 9),
                        hintText: '0.0',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      labelBottom,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Consumer<InsertBlock>(
                    builder: (_, __, ___) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          ' \$ $saldo',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
