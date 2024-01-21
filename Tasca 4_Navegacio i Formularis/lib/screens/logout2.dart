import 'package:flutter/material.dart';

class Logout2 extends StatelessWidget {
  Logout2({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/bg.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Builder(builder: (context2) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: null,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,  "al posar el SingleChildScrollView no fa efecte i pertant em de posar els Espaciadors"
                    children: [
                      const Text(
                        'Registre',
                        style: TextStyle(
                          fontSize: 60.0,
                          color: Colors.black,
                          fontFamily: 'LeckerliOne',
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(5.0, 5.0),
                              blurRadius: 2.0,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0), // Espaciador
                      SizedBox(
                        width: 400.0,
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Usuari',
                            suffixIcon: const Icon(Icons.people_alt),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0), // Espaciador
                      Center(
                        //Veure l'explicació del center al final del codi
                        child: SizedBox(
                          width: 400,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Contrassenya',
                              suffixIcon: const Icon(Icons.lock_clock_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60.0), // Espaciador
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_usernameController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty) {
                                Navigator.pop(
                                  context,
                                  {
                                    'username': _usernameController.text,
                                    'password': _passwordController.text
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context2).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Dades incorrectes, no pots deixar camps buits'),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              "Registra't",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          const SizedBox(width: 40.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel.la',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
