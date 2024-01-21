import 'package:flutter/material.dart';
import 'package:tasca_ginys/data/comarques.dart';
import 'package:tasca_ginys/screens/info_pantalles.dart';

class Comarques extends StatelessWidget {
  final int indexProvincia;
  const Comarques({required this.indexProvincia, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Comarques de ${provincies[indexProvincia]['provincia']}',
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ComarquesListView(
          lesProvincies: provincies[indexProvincia],
          comarcaSeleccionada: (indexComarca) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InfoComarcaPantalles(
                  comarcaInfo: provincies[indexProvincia]['comarques']
                      [indexComarca],
                ),
              ),
            );
          },
        ), //plenem el mapa lesProvincies amb l'objecte valencia
      ),
    );
  }
}

class ComarquesListView extends StatelessWidget {
  final Map<String, dynamic> lesProvincies;
  final Function(int) comarcaSeleccionada;

  const ComarquesListView(
      {super.key,
      required this.lesProvincies,
      required this.comarcaSeleccionada});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> comarques = lesProvincies['comarques'];

    return ListView.builder(
      itemCount: comarques.length,
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
                        comarques[index]['img'],
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
                    comarques[index]['comarca'],
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

/* Expliquem el widget ComarquesListView, aquest widget ha de tindre un atribut Map que es de tipo clau/valor, al nostre cas ha de ser una clau(String) i com a valor pot ser cualsevol cosa per aixo posem <dynamic>. Aquest atribut l'hem posat en una variable lesProvincies.
Aquesta variable conté un diccionari en blanc del que es preten omplirlo amb tot el contingut de data/comarques.dart
Però observem primer data/comarques.dart:
- Primer tenim una llista que conté 3 'objecte' que son [0],[1],[2]
    es a ha dir les provincies de la Com Val
- Segon cada 'objecte' Provincia te 3 atributs: provincia (nom de la provincia), img(Url d'una imatge de la provincia) i comarques (objectes amb diferents atributs), Del que deduim que els atributs els podem definir com diccionaris amb clau/valor.

Per tant quan fem lesProvincies: provincies[0], estem accedint a un diccionari que li hem posat de nom lesProvincies que te valor l'objecte [0] de la Llista provincies del fitxer data/comarques.dart, es a dir tot l'objecte València. D'aquesta manera accedim al fitcher. Pensa com si el fitcher en sí es un json, com si comarques.dart es diguera lesProvincies.

Per tant ara ja sabem que li pasem al constructor del widget ComarquesListView.

Ara com que el que volem es fer un ListView i el que volem es el llistat de les comarques de Valencia, creem una variable comarques de tipus List<Map<String, dynamic>> que contindra una llista d'objectes del atribut comarques del objecte València.

Al pasarli al constructor de ComarquesListView(lesProvincies: provincies[0]) el atribut lesProvincies ja té Valencia. Per tant lesProvincies['comarques'] accedim al objecte/atribut comarques, i posem totes les comarques a la llista.
List<Map<String, dynamic>> comarques = lesProvincies['comarques'];

Ara ja podem aprofitar el potencial de ListView.
*/