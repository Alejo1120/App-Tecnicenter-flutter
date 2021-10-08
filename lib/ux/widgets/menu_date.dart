import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruver/ux/const/colors.dart';

class MenuDate extends StatelessWidget {
  const MenuDate(
      {Key? key,
      required this.onPress,
      required this.back,
      required this.next,
      required this.date,
      required this.backOpcion,
      required this.opcion,
      required this.nextOpcion,
      required this.flex})
      : super(key: key);

  final VoidCallback onPress;
  final VoidCallback back;
  final VoidCallback next;
  final String date;
  final String backOpcion;
  final String opcion;
  final String nextOpcion;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 4,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => onPress(),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: primaryColor,
                      size: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        date,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: flex,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(backOpcion,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                              )),
                        )
                      ],
                    ),
                    onPressed: back,
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      opcion,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(nextOpcion,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                              )),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    onPressed: next,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
