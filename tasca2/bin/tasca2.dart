import 'dart:io';

import 'package:tasca2/peticions_http.dart';

void main(List<String> arguments) {
  String? ordre;
  String? args;

  List<String> llistaArgs = List.from(arguments);

  ordre = llistaArgs[0];

  llistaArgs.removeAt(0);
  args = llistaArgs.join(" ");

  if (llistaArgs.isEmpty) {
    print("\x1B[31mNombre d'arguments incorrecte\x1B[0m");
    exit(1);
  }

  if (ordre == "comarques") {
    if (args != "Castelló" && args != "València" && args != "Alacant") {
      print("\x1B[31mNo reconec la província.\x1B[0m");
      exit(1);
    } else {
      PeticionsHttp.obtenirComarques(args).then((comarques) {
        for (var nom in comarques) {
          print("\x1B[36m$nom\x1B[0m");
        }
      });
    }
  } else if (ordre == "infocomarca") {
    PeticionsHttp.obtenirInfoComarca(args).then((comarca) {
      print(comarca);
    }).catchError((error) {
      print("\x1B[31m$error\x1B[0m");
      exit(1);
    });
  } else {
    print("\x1B[31mOrdre desconeguda\x1B[0m");
    exit(1);
  }
}
