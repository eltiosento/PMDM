import 'dart:async';

import 'package:tasca_ginys/model/comarca.dart';
import 'package:tasca_ginys/model/infooratge.dart';
import 'package:tasca_ginys/repository/oratge_repository.dart';

class OratgeBloc {
  static OratgeBloc? _oratgeBloc;

  OratgeBloc._();

  factory OratgeBloc() {
    _oratgeBloc ??= OratgeBloc._();
    return _oratgeBloc!;
  }

  //Referència al repository Oratge
  final _oratgeRepository = OratgeRepository();

  //Referència a un objecte de tipus Comarca que podrà ser null, vindra emplenat desde la crida del usuari al punxar en comarca, es a dir quan carreguem la comarca al Bloc de comarques.
  //Aixi quan accedim a la pantalla del oratge i cridem a obtindreComarcaActual i ja te comarques que comparar.
  Comarca? comarcaActual;
  //Referència a infoOratge que contindrà la informació del oratge de la comarca actual
  InfoOratge? infoOratge;

  // Controlador per a la informació del oratge de la comarca actual
  final _infoOratgeController = StreamController<InfoOratge?>.broadcast();

  Stream<InfoOratge?> get obtenirInfoOratgeStream =>
      _infoOratgeController.stream;

  set obtindreComarcaActual(Comarca? comarca) {
    if (comarca != null) {
      //Al pareixer amb dart no cal fer el override del equals a la classe, per comparar objectes.
      if (comarcaActual != comarca) {
        comarcaActual = comarca;
        carregaOratge(comarca);
      } else {
        actualitzaOratge();
      }
    }
  }

  void carregaOratge(Comarca comarca) async {
    InfoOratge? oratge = await _oratgeRepository.obteClima(
        longitud: comarca.longitud!.toDouble(),
        latitud: comarca.latitud!.toDouble());
    infoOratge = oratge;
    _infoOratgeController.sink.add(infoOratge);
  }

  void actualitzaOratge() async {
    await Future.delayed(Duration.zero);
    _infoOratgeController.sink.add(infoOratge);
  }

  void dispose() {
    _infoOratgeController.close();
  }
}
