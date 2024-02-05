import 'package:flutter/material.dart';
import 'package:tasca_ginys/bloc/comarques_bloc.dart';
import 'package:tasca_ginys/model/comarca.dart';
import 'package:tasca_ginys/screens/info_comarca_1.dart';
import 'package:tasca_ginys/screens/info_comarca_2.dart';

class InfoComarcaPantalles extends StatefulWidget {
  final String nomComarca;
  const InfoComarcaPantalles({super.key, required this.nomComarca});

  @override
  State<InfoComarcaPantalles> createState() => _InfoComarcaPantallesState();
}

class _InfoComarcaPantallesState extends State<InfoComarcaPantalles> {
  // Ens suscrivim al BLOC que te totes les plataformes de Stream
  final ComarquesBloc comarquesBloc = ComarquesBloc();
  // index per al BottomNavigationBar
  late int indexActual = 0;

  @override
  Widget build(BuildContext context) {
    // Utilitzem el Setter per establir la comarca actual. per tant ara vorem vorem Disney
    comarquesBloc.nomComarcaActual = widget.nomComarca;

    return StreamBuilder(
      stream: comarquesBloc.obtenirComarcaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Asi ho farem com ho teniem, amb la tasca Futures, mentre esperem la resposta fes el cerclet i quan la tingues cosntrueix el widget.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Error al carregar la informació de la comarca');
        } else {
          //CONSTRUIM WIDGET
          Comarca comarca = snapshot.data;

          return Scaffold(
            appBar: null,
            body: indexActual == 0
                ? InfoComarca(
                    comarca: comarca,
                    //comarcaNom: widget.nomComarca,
                  )
                : InfoComarca2(
                    comarca: comarca,
                    //comarcaNom: widget.nomComarca,
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
