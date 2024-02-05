import 'package:flutter/material.dart';
import 'package:tasca_ginys/bloc/comarques_bloc.dart';
import 'package:tasca_ginys/screens/info_pantalles.dart';
//import 'package:tasca_ginys/screens/info_pantalles.dart';

class Comarques extends StatelessWidget {
  final String provinciaNom;
  Comarques({required this.provinciaNom, super.key});

  // Definim una referència al BLoC
  final ComarquesBloc comarquesBloc = ComarquesBloc();

  @override
  Widget build(BuildContext context) {
    // Utilitzem el Setter per establir la provincia actual.
    comarquesBloc.provinciaActual = provinciaNom;

    return StreamBuilder(
      // provinciaActual esta cridant a carregaComarques() de ComarquesBloc i carregaComarques() esta retransmitint pel canal HBO (obtenirComarquesStream) pues bueno com que estem subscrit podem observar que passa i actuar en conseqüència, perque tenim la imatge al snapshot.
      stream: comarquesBloc.obtenirComarquesStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          List<dynamic> listComarques = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Comarques de $provinciaNom',
              ),
            ),
            body: ComarquesListView(
              lesProvincies: listComarques,
              comarcaSeleccionada: (indexComarca) {
                //ara li pasarem provincies[indexComarca]['nom']

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoComarcaPantalles(
                      nomComarca: listComarques[indexComarca]['nom'],
                    ),
                  ),
                );
              },
            ), //plenem el mapa lesProvincies amb l'objecte valencia
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class ComarquesListView extends StatelessWidget {
  final List<dynamic> lesProvincies;
  final Function(int) comarcaSeleccionada;

  const ComarquesListView(
      {super.key,
      required this.lesProvincies,
      required this.comarcaSeleccionada});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lesProvincies.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              comarcaSeleccionada(index);
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .stretch, //Com tenim una Columna dins dun Card amb crossAxisAlignment diem que sestire la columna en tot el card
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        lesProvincies[index]['img'],
                        height: 150, // Altura de la image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  left: 15,
                  right: 0,
                  child: Text(
                    lesProvincies[index]['nom'],
                    style: const TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'LeckerliOne',
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 3.0,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
