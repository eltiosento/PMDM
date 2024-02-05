//Podriem fer asi una clase staic per a que poguerem tindre acces a esta clase sense fer cap instancia nova de la clase. Com em fet a Srping en java amb les clases DTO per al metodes Model2DTO que eren static i els podiem utilitzar a tot arreu del programa. Perrò amb dart gastarem Singleton que gasta factory.

import 'dart:async';

import 'package:tasca_ginys/bloc/oratge_bloc.dart';
import 'package:tasca_ginys/model/comarca.dart';
import 'package:tasca_ginys/model/provincia.dart';
import 'package:tasca_ginys/repository/comarques_repository.dart';

class ComarquesBloc {
  /* Implementació del patró Singleton */

  // Declarem una referència interna (privada _loQueSiga) a
  // una instància de la mateixa classe.
  // Aquesta propietat ha de ser estàtica per poder
  // referenciar-se des d'un constructor de factoría
  static ComarquesBloc? _comarquesBloc;

  // Declarem un constructor privat amb nom (_), de
  // manera que només es puga invocar des de dins
  ComarquesBloc._() {
    carregaProvincies();
  }

  // Definim el constructor com un mètode de factoria per
  // obtenir la instància o crear-ne una nova.

  factory ComarquesBloc() {
    // Utilitzem l'operador ??= per assignar
    // valor només si aquest és nul. Si la referència
    // _comarquesBloc és nul·la, crearem una nova instància
    // amb el constructor privat. Si la referència no és
    // nul·la, retornarem la que ja existeix.
    _comarquesBloc ??= ComarquesBloc._();
    return _comarquesBloc!;
  }
//--------------------------  ##Fi del constructor de la classe. IMPLEMENTEM ATRIBUTS##  -------------------------------------------
  // Referenciem el repository
  final _comarquesRepository = ComarquesRepository();

  final OratgeBloc oratgeBloc = OratgeBloc();

  String? _provinciaActual;
  List<dynamic>? _llistaComarques;
  String? _nomComarcaActual;
  Comarca? comarcaActual;
//---------------------------## CONTROLADORS ## -----------------------------
  // Controlador per a la llista de provincies.
  //StreamController el gastem per a peritir el flux de dades i poder emetre esdevenimets als nostres subscriptors SON ELS TRANSMISORS D'INFORMACIÓ.
  //Per això hem creat un CONTROLADOR que transmitirà llistes d'objectes de la classe Porvinca i permetrà tindre diversos subscriptors mitjançant el mètode broadcast.
  //De forma que quan ens suscrivirem a aquest controlador fent "stream" podrem fer també ".listen" per poder rebre les notificacions s'estiguen emitint noves llistes de Provincies. (Igualment a la resta de controladors).
  final _provinciesController =
      StreamController<List<Provincia>>.broadcast(); //ESTE SERA NETFLIX

// Controlador per a la llista de comarques de la província actual
  final _comarquesController =
      StreamController<List<dynamic>?>.broadcast(); //ESTE SERA HBO

// Controlador per a la informació de la comarca actual
  final _comarcaActualController =
      StreamController<Comarca?>.broadcast(); //ESTE SERA DISNEY

//-------------- ##GETTERS## ------------------------------------
// Getter per a l'Stream de _provinciesController:
// Retorna l'stream sobre el qual s'emetrà la llista de províncies
// en la creació del BLoC.
// Aquest mètode l'utilitzarà la pantalla de selecció de províncies i per tant quedarà suscrita al controlador respectiu.
  Stream<List<Provincia>> get obtenirProvinciesStream =>
      _provinciesController.stream;

// Getter per a l'Stream de _comarquesController:
// Retorna l'stream sobre el qual s'emetrà la llista amb el nom i
// la imatge descriptiva de cada comarca quan se seleccione una província.
// Aquest mètode l'utilitzarà la pantalla de selecció de comarques i per tant quedarà suscrita al controlador respectiu.
  Stream<List<dynamic>?> get obtenirComarquesStream =>
      _comarquesController.stream;

// Getter per a l'Stream de _comarcaActualController
// Retorna l'stream sobre el qual s'emetrà la informació
// completa de la comarca seleccionada al selector de comarques.
// Aquest mètode l'utilitzarà la pantalla que mostra la informació
// sobre la comarca (la pestanya general) quedant suscrit al controlador.
  Stream<Comarca?> get obtenirComarcaStream => _comarcaActualController.stream;

//-------------- ##SETTERS## ------------------------------------
// Son per a posar la provincia y la comarca actual.
  set provinciaActual(String? provincia) {
    if (provincia != null) {
      if (_provinciaActual != provincia) {
        _provinciaActual = provincia;
        carregaComarques(_provinciaActual!);
      } else {
        actualitzaComarques(); //com fer un F5
      }
    }
  }

  set nomComarcaActual(String? comarca) {
    if (comarca != null) {
      if (_nomComarcaActual != comarca) {
        _nomComarcaActual = comarca;
        carregaComarca(comarca);
      } else {
        //En cas que la comarca que es proporciona fora la que ja estiguera seleccionada, s’invoca al mètode actualitzaComarca, per reenviar aquesta informació per l’Stream, fent prèviament una espera asíncrona de durada zero.
        actualitzaComarca();
      }
    }
  }

//-------------- ##MÈTODE DE LA CLASSE## ------------------------------------

//Metode que Actualitza l'estat ###Eplicat al final del arxiu.
  void carregaProvincies() async {
    // Obtenim les províncies de del mètode corresponent del repositori
    List<dynamic> jsonProvincies =
        await _comarquesRepository.obtenirProvincies();

    //  El mapegem a una llista de províncies, per a tornar objectes provincia a partir de un json, ja en el repository arreplegeum list<dynamic>
    // i el que volem es Provincia, Mirar com s'ha fet en comarca, son 2 formes de fer-ho (ho fem aci o en el repository).
    List<Provincia> provincies = List<Provincia>.from(
        jsonProvincies.map((provincia) => Provincia.fromJSON(provincia)));

    // I l'afegim a l'Stream de les províncies (sink es la forma del controlador per afegir EVENTS al fluxe de dades)
    _provinciesController.sink.add(provincies);
  }

  void carregaComarques(String provincia) async {
    // Obtenim la llista de comarques amb el mètode corresponent del repositori
    List<dynamic> jsonComarques =
        await _comarquesRepository.obtenirComarques(provincia);
    _llistaComarques = jsonComarques;

    // Emetem la llista per l'Stream corresponent
    _comarquesController.sink.add(_llistaComarques);
  }

  void actualitzaComarques() async {
    //Aquest mètode és per a que NO tornar a fer la petició a la API carregant de nou les comarques, sobre tot quan fem scroll(RecycleView), d'aquesta manera es comprova que no em cambiat de provincia, aleshores no cal tornar a cridar a la api. d'aqueta manera el controlador estarà emitint la llista actual, sense fer peticions a la api novament(a diferencia de carregaComarques que si que crida a obtenirComarques).
    // Hem d'afegim una espera asíncrona de durada zero (Zero-Duration Delay) per a que el consumidor tinga temps a suscriures abans de que el controlador emeta el flux.
    //Tipica carrega al fer F5.
    await Future.delayed(Duration.zero);
    // Emetem llista de comarques actual per l'Stream
    _comarquesController.sink.add(_llistaComarques);
  }

  void carregaComarca(String comarca) async {
    // Obtenim la informació sobre la comarca a través del repositori
    // i l'afegim a l'Stream del controlador corresponent. Aci no mapegem perque je ens ve el en forma d'objecte Comarca,
    //perque el .fromJSON l'hem fet en el repositori
    Comarca? infoComarca =
        await _comarquesRepository.obtenirInfoComarca(comarca);
    comarcaActual = infoComarca;
    _comarcaActualController.sink.add(comarcaActual);

    // Quan obtenem la informació d'una comarca, actualitzem la propietat comarcaActual del BLoC de l'oratge amb el metode setter, perque em de SINCRONITZAR les vistes encara que primer gastarem una i després l'altra. Ambdues vistes van a utilitzar el contingut del objecte comarca. ES a dir, infopantalles agafa el obtenirComarcaStream i li enxufa eixa comarca a les 2 pantalles que es generen a l'hora, pertant hem de pasar tambe la informacio del oratge per a la segon pantalla.
    // Este setter agafa la comarca i carrega l'oratge
    oratgeBloc.obtindreComarcaActual = comarcaActual;
  }

  void actualitzaComarca() async {
    // Afegim una espera asíncrona de durada zero (Zero-Duration Delay)
    await Future.delayed(Duration.zero);
    // Emetem la informació de la comarca actual per l'Stream de les comarques
    _comarcaActualController.sink.add(comarcaActual);
  }

  void dispose() {
    // Mètode per alliberar els recursos dels Streams
    _provinciesController.close();
    _comarquesController.close();
    _comarcaActualController.close();
  }
}

/* 
METODE carregaProvincies:
jsonProvincies es una lista dinámica que contiene datos en formato JSON representando provincias. Estos datos se obtienen llamando al método obtenirProvincies() del repositorio _comarquesRepository.

.map((provincia) => Provincia.fromJSON(provincia)): Aquí se utiliza el método map para convertir cada elemento de la lista jsonProvincies en un objeto Provincia. Para hacer esto, se llama al constructor Provincia.fromJSON() y se pasa cada elemento (provincia) como argumento. Esto asume que la clase Provincia tiene un constructor llamado fromJSON que toma un mapa (Map<String, dynamic>) y crea una instancia de Provincia a partir de él.

List<Provincia>.from(...): Finalmente, List.from se utiliza para crear una nueva lista de tipo Provincia a partir de la lista generada por el map. 

En resumen, esta línea de código está transformando una lista de datos en formato JSON (jsonProvincies) en una lista de objetos Provincia utilizando el constructor Provincia.fromJSON. La nueva lista (provincies) se utilizará más adelante y se agregará al controlador de transmisión _provinciesController.
*/
