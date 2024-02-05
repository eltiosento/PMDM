import 'package:flutter/material.dart';
import 'package:tasca_ginys/model/comarca.dart';

class InfoComarca extends StatelessWidget {
  final Comarca comarca;
  //final String comarcaNom;
  const InfoComarca({super.key, required this.comarca});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('${comarca.comarca}.General'),
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
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                child: Container(
                  width: 400,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          "assets/img/42.jpg",
                          width: 350,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    comarca.comarca,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    'Capital: ${comarca.capital}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: 350,
                      child: Text(
                        comarca.desc!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
