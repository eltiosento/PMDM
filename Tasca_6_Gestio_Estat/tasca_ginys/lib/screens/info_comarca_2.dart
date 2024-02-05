import 'package:flutter/material.dart';
import 'package:tasca_ginys/bloc/oratge_bloc.dart';
import 'package:tasca_ginys/model/comarca.dart';
import 'package:tasca_ginys/model/infooratge.dart';

class InfoComarca2 extends StatelessWidget {
  final Comarca comarca;
  InfoComarca2({super.key, required this.comarca});
  final OratgeBloc oratgeBloc = OratgeBloc();

  @override
  Widget build(BuildContext context) {
    // Caldrà sincronitzar la generació de vistes amb l'emissió dels esdeveniments als Streams. Per exemple, quan obtenim la informació sobre l'oratge i l'emetem per l'Stream per primera vegada, no hi haurà cap observador preparat. En canvi, quan obrim la pestanya de la informació sobre l'oratge, necessitarem que es torne a enviar la informació per l'Stream per no quedar-nos contínuament a l'espera. Això ho podem aconseguir invocant directament al mètode actualitzaOratge() de oratge_bloc.
    oratgeBloc.actualitzaOratge();

    return StreamBuilder(
      stream: oratgeBloc.obtenirInfoOratgeStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
          InfoOratge infoOratge = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('${comarca.comarca}.Oratge'),
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
                            child: SizedBox(
                              width: 300,
                              child: _obtenirIconaOratge(
                                  infoOratge.codiOratge.toString()),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.thermostat,
                              size: 20,
                            ),
                            Text(
                              '${infoOratge.temperatura}º',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.wind_power,
                              size: 20,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "${infoOratge.velocitatVent}km/h",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 40),
                            _obteGinyDireccioVent(
                                infoOratge.direccioVent.toString()),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Població:     ${comarca.poblacio}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Latitud:     ${comarca.latitud}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Longitud:   ${comarca.longitud}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
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
      },
    );
  }
}

Widget _obtenirIconaOratge(String value) {
  Set<String> sol = <String>{"0"};
  Set<String> pocsNuvols = <String>{"1", "2", "3"};
  Set<String> nuvols = <String>{"45", "48"};
  Set<String> plujasuau = <String>{"51", "53", "55"};
  Set<String> pluja = <String>{
    "61",
    "63",
    "65",
    "66",
    "67",
    "80",
    "81",
    "82",
    "95",
    "96",
    "99"
  };
  Set<String> neu = <String>{"71", "73", "75", "77", "85", "86"};

  if (sol.contains(value)) {
    return Image.asset("assets/icons/soleado.png");
  }
  if (pocsNuvols.contains(value)) {
    return Image.asset("assets/icons/poco_nublado.png");
  }
  if (nuvols.contains(value)) {
    return Image.asset("assets/icons/nublado.png");
  }
  if (plujasuau.contains(value)) {
    return Image.asset("assets/icons/lluvia_debil.png");
  }
  if (pluja.contains(value)) {
    return Image.asset("assets/icons/lluvia.png");
  }
  if (neu.contains(value)) {
    return Image.asset("assets/icons/nieve.png");
  }

  return Image.asset("assets/icons/poco_nublado.png");
}

Widget _obteGinyDireccioVent(String direccioVent) {
  // Aquesta funció ens retorna una giny que conté
  // una icona i un text, amb la direcció i el nom del vent
  // segons la seua direcció.
  // Fem ús de `late` per indicar que assignarem el valor després
  // a les variables.

  double direccio = double.parse(direccioVent);
  late Icon icona;
  late String nomVent;

  if (direccio > 22.5 && direccio < 65.5) {
    icona = const Icon(Icons.north_east);
    nomVent = "Gregal";
  } else if (direccio > 67.5 && direccio < 112.5) {
    icona = const Icon(Icons.east);
    nomVent = "Llevant";
  } else if (direccio > 112.5 && direccio < 157.5) {
    icona = const Icon(Icons.south_east);
    nomVent = "Xaloc";
  } else if (direccio > 157.5 && direccio < 202.5) {
    icona = const Icon(Icons.south);
    nomVent = "Migjorn";
  } else if (direccio > 202.5 && direccio < 247.5) {
    icona = const Icon(Icons.south_west);
    nomVent = "Llebeig/Garbí";
  } else if (direccio > 247.5 && direccio < 292.5) {
    icona = const Icon(Icons.west);
    nomVent = "Ponent";
  } else if (direccio > 292.5 && direccio < 337.5) {
    icona = const Icon(Icons.north_west);
    nomVent = "Mestral";
  } else {
    icona = const Icon(Icons.north);
    nomVent = "Tramuntana";
  }
  return Row(
    children: [
      Text(
        nomVent,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      icona,
    ],
  );
}