import 'package:flutter/material.dart';
import 'package:tasca_ginys/data/comarques.dart';
import 'package:tasca_ginys/screens/comarques.dart';

class Provincies extends StatelessWidget {
  const Provincies({super.key});

  @override
  Widget build(BuildContext context) {
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
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Comarques(indexProvincia: 0),
                      ),
                    );
                  },
                  child: GinyProvincia(
                    nomProvincia: provincies[0]["provincia"],
                    imageUrl: provincies[0]["img"],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Comarques(indexProvincia: 1),
                      ),
                    );
                  },
                  child: GinyProvincia(
                    nomProvincia: provincies[1]["provincia"],
                    imageUrl: provincies[1]["img"],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Comarques(indexProvincia: 2),
                      ),
                    );
                  },
                  child: GinyProvincia(
                    nomProvincia: provincies[2]["provincia"],
                    imageUrl: provincies[2]["img"],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
