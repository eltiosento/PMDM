import 'dart:convert';
import 'package:http/http.dart' as http;
import 'comarca.dart';

class PeticionsHttp {
  // Torna tota la api. mostra tot el json
  static Future<String> obtenirAPI(String provincia) async {
    var url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia";

    var response = await http.get(Uri.parse(url));

    //si el que ens retorna es algo sera el status code 200
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final bodyJSON = jsonDecode(body) as List;

      return bodyJSON.toString();
    } else {
      throw Exception("Error amb la connexió.");
    }
  }

  static Future<Comarca> obtenirInfoComarca(String comarca) async {
    var url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final bodyJSON = jsonDecode(body);

      return Comarca.fromJSON(bodyJSON);
    } else if (response.statusCode == 404) {
      throw Exception("No reconec la comarca");
    } else {
      throw Exception("\x1B[31mError amb la connexió.\x1B[0m");
    }
  }

  static Future<List<String>> obtenirComarques(String provincia) async {
    var url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final bodyJSON = jsonDecode(body);

      // Extarure els noms de les comarques
      List<String> nomsComarques = [];
      for (var item in bodyJSON) {
        nomsComarques.add(item['nom']);
      }
      return nomsComarques;
    } else {
      throw Exception("Error amb la connexió");
    }
  }
}
