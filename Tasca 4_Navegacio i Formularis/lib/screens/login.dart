import 'package:flutter/material.dart';
import 'package:tasca_ginys/screens/logout.dart';
import 'package:tasca_ginys/screens/provincies.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Scaffold(
        //backgroundColor: Colors.transparent,
        appBar: null,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/bg.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
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
                  const Formulari(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Hem posat un fill de la columna en un center per a obligar al SingleChildScrollView a centar la columna i poder fer scroll desde el borde de la finestra principal

class Formulari extends StatefulWidget {
  const Formulari({super.key});

  @override
  State<Formulari> createState() => _FormulariState();
}

class _FormulariState extends State<Formulari> {
  final TextEditingController _usernameController =
      TextEditingController(); // Per pasar y rebre informació de formularis
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _estatFormulari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _estatFormulari, //Per controlar els estat del TextFormField
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          SizedBox(
            width: 400.0,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Aquest camp no pot estar buit.";
                }

                return null;
              },
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

          SizedBox(
            width: 400,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Aquest camp no pot estar buit.";
                }

                return null;
              },
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
          const SizedBox(height: 60.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (_estatFormulari.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Provincies(),
                      ),
                    );
                    print("tot be");
                  } else {
                    print("hi ha errors");
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(width: 60.0),
              ElevatedButton(
                onPressed: () async {
                  Map<String, String>? resposta = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Logout(),
                    ),
                  );

                  if (resposta != null) {
                    _usernameController.text = resposta['username'] ?? "";
                    _passwordController.text = resposta['password'] ?? "";
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
