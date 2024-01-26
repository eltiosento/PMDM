import 'package:flutter/material.dart';
import 'package:tasca_ginys/data/peticions_http.dart';
import 'package:tasca_ginys/screens/info_pantalles.dart';
//import 'package:tasca_ginys/screens/info_pantalles.dart';

class Comarques extends StatelessWidget {
  final String provinciaNom;
  const Comarques({required this.provinciaNom, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PeticionsHttp.obtenirComarques(provinciaNom),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        //Podem fer-ho aixi o com està a la pantalla de Provincies
        // has.Data en diu si sa resolt, per tant quan torne true, avant!
        if (snapshot.hasData) {
          List<dynamic> listComarques = snapshot.data!;

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
          return const Text('Error al carregar les comarques');
        } else {
          return const Center(
            child: SizedBox(
              height: 200,
              width: 200,
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
