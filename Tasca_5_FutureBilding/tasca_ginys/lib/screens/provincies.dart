import 'package:flutter/material.dart';
//import 'package:tasca_ginys/data/comarques.dart';
//import 'package:tasca_ginys/screens/comarques.dart';
import 'package:tasca_ginys/data/peticions_http.dart';
import 'package:tasca_ginys/screens/comarques.dart';

class Provincies extends StatelessWidget {
  const Provincies({super.key});

  _creaLlistaProvincies(BuildContext context, List<dynamic> llistaProvincies) {
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
                  provinciaNom: llistaProvincies[i]["provincia"],
                ),
              ),
            );
          },
          child: GinyProvincia(
            nomProvincia: llistaProvincies[i]["provincia"]!,
            imageUrl: llistaProvincies[i]["img"]!,
          ),
        ),
      );
    }
    return llista;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PeticionsHttp.obtenirProvincies(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Error al carregar les provincies');
        } else {
          List<dynamic> listProvincies = snapshot.data as List<dynamic>;

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
                    children: _creaLlistaProvincies(context, listProvincies),
                  ),
                ),
              ),
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
