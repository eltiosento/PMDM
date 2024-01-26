import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class PeticionsHttp {
  static Future<Map<String, dynamic>> obtenirInfoComarca(String comarca) async {
    String url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> resultat = jsonDecode(body);

      return resultat;
    } else {
      throw Exception("Error amb la connexió.");
    }
  }

  static Future<List<dynamic>> obtenirComarques(String provincia) async {
    String url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final List<dynamic> resultat = jsonDecode(body);

      return resultat;
    } else {
      throw Exception("Error amb la connexió");
    }
  }

  static Future<List<dynamic>> obtenirProvincies() async {
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

  static Future<Map<String, dynamic>> obteClima(
      {required double longitud, required double latitud}) async {
    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitud&longitude=$longitud&current_weather=true';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == HttpStatus.ok) {
      String body = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> resultat = jsonDecode(body);

      return resultat;
    } else {
      throw Exception("No s'ha pogut connectar");
    }
  }
}
