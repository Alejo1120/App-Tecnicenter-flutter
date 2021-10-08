import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruver/ux/const/colors.dart';
import 'package:intl/intl.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({
    Key? key,
    required this.saldoInicial,
    required this.ventas,
    required this.gastos,
    required this.ganancias,
  }) : super(key: key);

  final int saldoInicial;
  final int ventas;
  final int gastos;
  final int ganancias;

  @override
  Widget build(BuildContext context) {
    final NumberFormat f = NumberFormat();
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Ganancias totales',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '\$ ${f.format(ganancias)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 110,
            color: primaryColor,
            margin: const EdgeInsets.symmetric(horizontal: 5),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SvgPicture.asset(
                        'assets/icons/money0.svg',
                        width: 25,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Base inicial',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                  '\$',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[300],
                                  ),
                                ),
                              ),
                              Text(
                                f.format(saldoInicial),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[300],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 15),
                      child: SvgPicture.asset(
                        'assets/icons/money1.svg',
                        width: 25,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ventas totales',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                  '\$',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[300],
                                  ),
                                ),
                              ),
                              Text(
                                f.format(ventas),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[300],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 15),
                      child: SvgPicture.asset(
                        'assets/icons/money2.svg',
                        width: 25,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gastos totales',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                  '\$',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[300],
                                  ),
                                ),
                              ),
                              Text(
                                f.format(gastos),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[300],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
