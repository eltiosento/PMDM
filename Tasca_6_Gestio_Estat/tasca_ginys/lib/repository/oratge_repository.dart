import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tasca_ginys/model/infooratge.dart';

class OratgeRepository {
  Future<InfoOratge> obteClima(
      {required double longitud, required double latitud}) async {
    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitud&longitude=$longitud&current_weather=true';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == HttpStatus.ok) {
      String body = utf8.decode(response.bodyBytes);
      final infoOratgeJSON = jsonDecode(body);

      return InfoOratge.fromJSON(infoOratgeJSON);
    } else {
      throw Exception("No he pogut fer la peticio a Info Oratge");
    }
  }
}
