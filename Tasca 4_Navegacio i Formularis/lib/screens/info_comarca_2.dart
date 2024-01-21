import 'package:flutter/material.dart';

class InfoComarca2 extends StatelessWidget {
  final Map<String, dynamic> comarcaInfo;
  const InfoComarca2({super.key, required this.comarcaInfo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InfoComarca Oratge',
      // Una altra forma de posar el fondo i organitzar els elements
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/bg.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('${comarcaInfo['comarca']}.Oratge'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Stack(
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
                        padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                        child: SizedBox(
                          width: 300,
                          child: Image.asset('assets/icons/soleado.png'),
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thermostat,
                          size: 20,
                        ),
                        Text(
                          '5º',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wind_power,
                          size: 20,
                        ),
                        SizedBox(width: 20),
                        Text(
                          '20 km/h',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 40),
                        Text(
                          'Tramuntana',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Població:     ${comarcaInfo['poblacio']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Latitud:     ${comarcaInfo['latitud']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Longitud:   ${comarcaInfo['longitud']}',
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
      ),
    );
  }
}
