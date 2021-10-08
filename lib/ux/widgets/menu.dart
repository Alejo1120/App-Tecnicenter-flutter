import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fruver/ux/const/colors.dart';
import 'package:fruver/ux/home/home_block.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final block = Provider.of<HomeBlock>(context);
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all( //color borde contenedor donde esta dia mes año
          color: Colors.black12,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => block.setIndexPage(0),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (block.indexPage == 0)
                      ? primaryColor
                      : Colors.transparent,
                ),
                child: Text(
                  'Dia',
                  style: TextStyle(
                    fontSize: 16,
                    color: (block.indexPage == 0) ? Colors.white : primaryColor,
                    fontWeight: (block.indexPage == 0)
                        ? FontWeight.bold
                        : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => block.setIndexPage(1),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (block.indexPage == 1)
                      ? primaryColor
                      : Colors.transparent,
                ),
                child: Text(
                  'Mes',
                  style: TextStyle(
                    fontSize: 16,
                    color: (block.indexPage == 1) ? Colors.white : Colors.black,
                    fontWeight: (block.indexPage == 1)
                        ? FontWeight.bold
                        : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => block.setIndexPage(2),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (block.indexPage == 2)
                      ? primaryColor
                      : Colors.transparent,
                ),
                child: Text(
                  'Año',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: (block.indexPage == 2) ? Colors.white : Colors.black,
                    fontWeight: (block.indexPage == 2)
                        ? FontWeight.bold
                        : FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
