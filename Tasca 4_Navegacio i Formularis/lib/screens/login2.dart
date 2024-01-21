import 'package:flutter/material.dart';
import 'package:tasca_ginys/screens/logout2.dart';
import 'package:tasca_ginys/screens/provincies.dart';

class Login2 extends StatelessWidget {
  Login2({super.key});
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
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: null,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,  "al posar el SingleChildScrollView no fa efecte i pertant em de posar els Espaciadors"
                  children: [
                    Image.asset(
                      'assets/img/logo.png',
                      width: 300.0,
                      height: 300.0,
                    ),
                    const Text(
                      'Les nostres comarques',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                        fontFamily: 'LeckerliOne',
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
                            suffixIcon: const Icon(Icons.lock_clock),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Provincies(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Dades incorrectes, no pots deixar camps buits'),
                                ),
                              );
                            }
                          },
                          child: const Text('Login'),
                        ),
                        const SizedBox(width: 60.0),
                        ElevatedButton(
                          onPressed: () async {
                            Map<String, String>? resposta =
                                await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Logout2(),
                              ),
                            );

                            if (resposta != null) {
                              _usernameController.text =
                                  resposta['username'] ?? "";
                              _passwordController.text =
                                  resposta['password'] ?? "";
                            }
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Hem posat un fill de la columna en un center per a obligar al SingleChildScrollView a centar la columna i poder fer scroll desde el borde de la finestra principal

