import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.only(top: 60),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                //mainAxisAlignment: MainAxisAlignment.center,  "al posar el SingleChildScrollView no fa efecte i pertant em de posar els Espaciadors"
                children: [
                  Text(
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
                  SizedBox(height: 20.0), // Espaciador
                  Formulari2(),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Formulari2 extends StatefulWidget {
  const Formulari2({super.key});

  @override
  State<Formulari2> createState() => _Formulari2State();
}

class _Formulari2State extends State<Formulari2> {
  final TextEditingController _usernameController2 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final GlobalKey<FormState> _estatFormulari2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _estatFormulari2,
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
              controller: _usernameController2,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Aquest camp no pot estar buit.";
                  }

                  return null;
                },
                controller: _passwordController2,
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
                  if (_estatFormulari2.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      {
                        'username': _usernameController2.text,
                        'password': _passwordController2.text
                      },
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
                onPressed: () async {
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
    );
  }
}
