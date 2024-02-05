import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tasca_ginys/model/comarca.dart';

class ComarquesRepository {
  Future<Comarca> obtenirInfoComarca(String comarca) async {
    String url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final comarcaJSON = jsonDecode(body);

      return Comarca.fromJSON(comarcaJSON);
    } else {
      throw Exception("Error amb la connexió per obtindre infocomarca.");
    }
  }

  Future<List<dynamic>> obtenirComarques(String provincia) async {
    String url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final List<dynamic> resultat = jsonDecode(body);

      return resultat;
    } else {
      throw Exception("Error amb la connexió per a obtindre comarques");
    }
  }

  Future<List<dynamic>> obtenirProvincies() async {
    String url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques";

    http.Response resposta = await http.get(Uri.parse(url));

    if (resposta.statusCode == 200) {
      String body = utf8.decode(resposta.bodyBytes);
      final List<dynamic> resultat = jsonDecode(body);

      return resultat;
    } else {
      throw Exception('Error al obtindre les provincies');
    }
  }
}
