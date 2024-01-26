import 'package:flutter/material.dart';
import 'package:tasca_ginys/data/peticions_http.dart';
import 'package:tasca_ginys/screens/info_comarca_1.dart';
import 'package:tasca_ginys/screens/info_comarca_2.dart';

class InfoComarcaPantalles extends StatefulWidget {
  final String nomComarca;
  const InfoComarcaPantalles({super.key, required this.nomComarca});

  @override
  State<InfoComarcaPantalles> createState() => _InfoComarcaPantallesState();
}

class _InfoComarcaPantallesState extends State<InfoComarcaPantalles> {
  int indexActual = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PeticionsHttp.obtenirInfoComarca(widget.nomComarca),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Error al carregar la informació de la comarca');
        } else {
          Map<String, dynamic> infoComarca = snapshot.data!;

          return Scaffold(
            appBar: null,
            body: indexActual == 0
                ? InfoComarca(
                    comarcaInfo: infoComarca,
                    comarcaNom: widget.nomComarca,
                  )
                : InfoComarca2(
                    comarcaInfo: infoComarca,
                    comarcaNom: widget.nomComarca,
                  ),
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
      },
    );
  }
}
