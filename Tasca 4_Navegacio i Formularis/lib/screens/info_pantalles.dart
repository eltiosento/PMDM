import 'package:flutter/material.dart';
import 'package:tasca_ginys/screens/info_comarca_1.dart';
import 'package:tasca_ginys/screens/info_comarca_2.dart';

class InfoComarcaPantalles extends StatefulWidget {
  final Map<String, dynamic> comarcaInfo;
  const InfoComarcaPantalles({super.key, required this.comarcaInfo});

  @override
  State<InfoComarcaPantalles> createState() => _InfoComarcaPantallesState();
}

class _InfoComarcaPantallesState extends State<InfoComarcaPantalles> {
  int indexActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: indexActual == 0
          ? InfoComarca(comarcaInfo: widget.comarcaInfo)
          : InfoComarca2(comarcaInfo: widget.comarcaInfo),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexActual,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'La comarca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: 'Informació i oratge',
          ),
        ],
        onTap: (index) {
          setState(
            () {
              indexActual = index;
            },
          );
        },
      ),
    );
  }
}
