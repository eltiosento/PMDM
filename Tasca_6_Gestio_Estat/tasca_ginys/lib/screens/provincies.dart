import 'package:flutter/material.dart';
import 'package:tasca_ginys/bloc/comarques_bloc.dart';
import 'package:tasca_ginys/model/provincia.dart';
import 'package:tasca_ginys/screens/comarques.dart';

class Provincies extends StatelessWidget {
  Provincies({super.key});
  //Ens suscrivim al BLOC que te totes les plataformes de Stream
  final ComarquesBloc comarquesBloc = ComarquesBloc();

  _creaLlistaProvincies(
      BuildContext context, List<Provincia> llistaProvincies) {
    List<Widget> llista = [];
    for (int i = 0; i < llistaProvincies.length; i++) {
      llista.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                //builder: (context) => Comarques(indexProvincia: i)
                builder: (context) => Comarques(
                  // Ara accedirem per atributs d'objectes a diferencia dels futures que rebiem directament de la API amb jsons
                  // que ho feiem amb llistaProvincies[i]["provincia"]
                  provinciaNom: llistaProvincies[i].nom,
                ),
              ),
            );
          },
          child: GinyProvincia(
            nomProvincia: llistaProvincies[i].nom,
            imageUrl: llistaProvincies[i].imatge ?? "",
          ),
        ),
      );
    }
    return llista;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Com estem suscrits al controlador i en este cas volem NETFLIX, ens posem a veure que retransmiteix.
      // Observem obtenirProvinciesStream (es un get) que està emitint _provinciesController.stream (mitjançant el mètode stream) Al crear comarquesBloc(al principi) s'inicialitza el seu mètode carregaProvincies() i estè metode se esta emitint mitjançant el canal _provinciesController per la plataforma NETFLIX (PER MITJÀ DE obtenirProvinciesStream)
      //PER TANT quan posem stream: i posem NETFLIX, estem observant tot el que passa, en este cas es carreguen les provincies y mitjançant la captura snapshot.data podem construir builder: lo que ve a ser la vista de la pantalla.
      stream: comarquesBloc.obtenirProvinciesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Provincia>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          //Hi ha que tindre en compter de quin tipus son les dades que ens arriben, en aquest cas ens arriba una llista d'objectes Provincia
          List<Provincia> listProvicies = snapshot.data!;
          return MaterialApp(
            title: 'Provincies',
            home: Scaffold(
              //backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text('Selector de Provincies'),
              ),
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/bg.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: _creaLlistaProvincies(
                        context, listProvicies), // li pasem
                  ),
                ),
              ),
            ),
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

class GinyProvincia extends StatelessWidget {
  final String nomProvincia;
  final String imageUrl;

  const GinyProvincia(
      {super.key, required this.nomProvincia, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 40),
        child: CircleAvatar(
          radius: 100,
          backgroundImage: NetworkImage(imageUrl),
          child: Text(
            nomProvincia,
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.white,
              fontFamily: 'LeckerliOne',
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(5.0, 5.0),
                  blurRadius: 2.0,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
