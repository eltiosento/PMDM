# CONSUM D'UNA API AMB LLENGUATGE DART


## ENUNCIAT
Anem a crear una xicoteta aplicació de consola per tal d’obtenir informació sobre les províncies icomarques del País Valencià.

La nostra aplicació oferirà des de la línia d’ordres dues funcionalitats:
- Obtenir un llistat de comarques per a una província indicada, i
- Obtenir la informació sobre una comarca en concret.

Per a això, la nostra aplicació rebrà diversos arguments per la línia d’ordres, actuant el primer com a subordre que ens indica el tipus de consulta a realitzar (comarques i infocomarca), i la resta dels arguments que aquesta necessita (el nom de la província o de la comarca en qüestió).
Per exemple, per obtenir les comarques de Castelló, executarem:
> dart run tasca2 comarques Castelló

I per tal d’obtenir informació sobre la comarca de “La Ribera Baixa”, farem:

> dart run tasca2 infocomarca La Ribera Baixa

Hem de tindre en compte que si utilitzem noms de comarca amb apòstrofs, caldrà escaparaquests. Per exemple:
> dart run tasca2 infocomarca L\'alcoià

## APIS

Per tal d’obtenir la informació sobre les províncies i comarques farem ús de l’API REST que hem
presentat a la unitat. Concretament, les rutes:
>https://node-comarques-rest-serverproduction.up.railway.app/api/comarques/comarquesAmbImatge/$provincia

>https://node-comarques-rest-serverproduction.up.railway.app/api/comarques/infoComarca/$comarca

Sent $provincia i $comarca la província i la comarca sobre la que volem demanar informació.

## DESCRIPCIÓ DEL PROJECTE
### Classe comarca:
Así el que hem fet es crear una classe Comarca amb l'objectiu de obtobre l'objecte comarca amb format JSON, i que modificant el seu toString pugam obtindre un llistat d'aqueste e imprimir-les amb el format desitjat.

Aquesta classe té com atributs:
``` Dart
  String comarca;
  String? capital;
  String? poblacio;
  String? img;
  String? desc;
  double? latitud;
  double? longitud;
```
Poguent ser tot NULS menys comarca. També li hem fet 2 constructors:
- Un constructor Comarca amb arguments amb nom, on tots seran opcionals, llevat de la
comarca (requerit). Gràcies a aquest podrem constuir el del Json.
- Un constructor amb nom Comarca.fromJSON, que rebrà un JSON a partir del qual
s’inicialitzarà. Aquest constructor conseguim que al fer Comarca.fromJSON(li pasem un json) ens creara l'objecte Comarca però amb format JSON.

``` Dart
  Comarca({
    required this.comarca,
    this.capital,
    this.poblacio,
    this.img,
    this.desc,
    this.latitud,
    this.longitud,
  });
  // aquest constructor crea una llista amb parelles de clau valor, on aquestes dades, son Strings i de tipus dynamic, es a dir la llisa pot variar. Aquesta llista li hem posat de nom objecteJSON. Es a dir: a comarca li assignes el valor que hi ha a una llista json de clau 'comarca' i amb ! li duem que no pot ser null.
  Comarca.fromJSON(Map<String, dynamic> objecteJSON): 
        comarca = objecteJSON['comarca']!,
        capital = objecteJSON['capital'],
        poblacio = objecteJSON['poblacio'],
        img = objecteJSON['img'],
        desc = objecteJSON['desc'],
        latitud = objecteJSON['latitud']?.toDouble(),
        longitud = objecteJSON['longitud']?.toDouble();
```
Finalment modificarem el toString de la Classe per a donarli el format desitjat. Si ho fem entre els entrecomillats '''   ''' el resultat és més o menys tal qual es veu: 

``` Dart
@override
  String toString() {
    return '''
    \x1B[33mnom:\x1B[0m             \x1B[36m$comarca\x1B[0m
    \x1B[33mcapital:\x1B[0m         \x1B[36m${capital ?? 'N/A'}\x1B[0m
    \x1B[33mpoblacio:\x1B[0m        \x1B[36m${poblacio ?? 'N/A'}\x1B[0m
    \x1B[33mImatge:\x1B[0m          \x1B[36m${img ?? 'N/A'}\x1B[0m
    \x1B[33mdescripció:\x1B[0m      \x1B[36m${desc ?? 'N/A'}\x1B[0m
    \x1B[33mCoordenades:\x1B[0m     \x1B[36m(${latitud ?? 'N/A'}, ${longitud ?? 'N/A'})\x1B[0m''';
  }
```
Resultat:  
    nom:             La Safor  
    capital:         Gandia  
    poblacio:        163.975  
    Imatge:          https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Circ_de_la_Safor.jpg/800px-Circ_de_la_Safor.jpg  
    descripció:      La Safor és una comarca valencianoparlant del centre del País Valencià, amb capital a Gandia. Històricament, la delimitació de la comarca de la Safor està relacionada amb l'existència del Ducat de Gandia, abans Senyoriu de Gandia.  
    Coordenades:     (38.9675925, -0.1803423)


### Classe PeticionsHttp:
Aquesta classe es la que s'encarrega de realitzar les peticions HHTP i crear els objectes necessaris, com son objecte Comarca i un json de la API:
``` Dart
// Fem els imports necessaris per a tractar les peticions i per fer convercions, 
//amés de la classe Comarca
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'comarca.dart';
```
Analitzem el mètode amb la qual mostrarem segons la provincia, les seues comarques.

```Dart
//Volem algo, UN OBJCETE, que ve del futur (CLASE FUTUR), en aquest cas, una llsita d'Strings i li posem el nom a la funcio que ens retornaraà aquest objecte Future.
//Li posem que es async perque voldre fer una espera amb un await. I li pasarem el nom d'una provincia. Aquesta funció mostra els noms de les comarques d'una provincia.
static Future<List<String>> obtenirComarques(String provincia) async {
  //variable amb la ruta de la API
    var url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia";

    //voldrem una resposta de eixa ruta, que serà la petició hhtp.get (http.get es a dir donam...) de la url, i li fem el Uri.parse . AMB EL AWAIT estem dient que espere a obtindre la resposta!!
    var response = await http.get(Uri.parse(url));

    //Si la resposta ens a tornat un codi 200, es que ha ixit exitosa i per tant
    //contruim el cos que es un string. Primer creem la variable body amb codificacio utf8
    //i li pasem la resposta. Ara bé, eixa resposta és un JSON, per tant creem una variable que contindra el json mitjançant un mètode jsonDecode que li passem el cos. per aixó em fet el import 'comarca.dart'.
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final bodyJSON = jsonDecode(body);

      // Un cop ja tenim el json, extaurem els noms de les comarques i les posarem en una llista d'Strings de nom nomsComarques i amb [] li diem que es una llsita
      List<String> nomsComarques = [];
      //Iterem la llista i per cada 'clau "nom"' li posem el seu valor.
      for (var item in bodyJSON) {
        nomsComarques.add(item['nom']);
      }
      // Tornem la llista, pero ojo!!! aquesta llista es un Future. hi ha que gastar then pa rebre el future. (mira-ho al main)
      return nomsComarques;

      // Sinós llancem una excepció.
    } else {
      throw Exception("Error amb la connexió");
    }
  }
```
Analitzem el mètode amb el qual crearem l'objecte comarca i li emplenarem les dades que ens demana el constructor Comarca.fromJSON:  

```Dart
//Funció amb la que obtindrem un objecte Futur. Aquest objecte serà un objecte Comarca
static Future<Comarca> obtenirInfoComarca(String comarca) async {
    var url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca";
    //posem en una variable lo que ens torna la api. Pero com que es algo
    //que no ve inmediatament, li em de dir que espere ha obtindre algo(es a dir,
    //podem obtindre una informacio buida tambe... i ens tornaria un codi distint al 200) per a que espere li posem el await.
    var response = await http.get(Uri.parse(url));

    //si el que ens retorna es algo sera el status code 200
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final bodyJSON = jsonDecode(body);

      // ara directament que ens torne un objecte Comarca creat pel constructor json
      return Comarca.fromJSON(bodyJSON);

      // Si esn torna un codi 404 esque hi ha un error amb la informació que estem demanant. es a dir, sa ppogut conectar pero no ha trobat el que voliem.
    } else if (response.statusCode == 404) {
      throw Exception("No reconec la comarca");
    } else {
      throw Exception("\x1B[31mError amb la connexió.\x1B[0m");
    }
  }
```


### Classe main:
Com hem comentat, el primer argument que proporcionem indica quina acció volem realitzar(comarques o infoComarca), i la resta d’arguments, bé el nom de la comarca o el de la província.
Per tal d’obtenir tots els arguments, llevat del primer, podem fer ús del mètode
removeAt() de laclasse List.
Ara bé, si utilitzem diretament aquest mètode sobre la llista d’arguments que rebem al
main,obtindrem l’error:
Unsupported operation: Cannot remove from a fixed-length list
Que com veiem, ens indica que no podem eliminar elements d’una llista de longitud fixa, com és la llista d’arguments del programa.
Per resoldre això, el que podem fer és crear una nova llista a partir de la llista d’arguments, amb:
```Dart
List<String> llistaArgs = List.from(arguments);
 ```
 De manera que podem obtindre l’ordre (infoComarca o comarques) i la resta d’arguments de lasegüent forma:
 
```Dart
  String? ordre;
  String? args;
  // Creem una còpia de la llista d'arguments del programa
  List<String> llistaArgs = List.from(arguments);
  
  // L'ordre és el primer argument
  ordre = llistaArgs[0];
  
  // Eliminem l'ordre
  llistaArgs.removeAt(0);
  
  // I reconstruim la resta d'arguments com un String,
  // separant-los amb un espai.
  args = llistaArgs.join(" ");
 ```
Analitzem la lògica ara del programa, es a dir a naem aveure que es el que volem:
```Dart 
//si els argument, el que vindria despres de la ordre, ja que aquesta la borrem...esta buit, doncs:
if (llistaArgs.isEmpty) {
    print("\x1B[31mNombre d'arguments incorrecte\x1B[0m");
    exit(1);
  }

  // si al ordre es comarques (aquesta ordre esta en la llista principal eee. la buidem de la segon llisat que creem)
  if (ordre == "comarques") {
    //comprovem que els arguments son els que volem, sino ten ixes amb un missatge
    if (args != "Castelló" && args != "València" && args != "Alacant") {
      print("\x1B[31mNo reconec la província.\x1B[0m");
      exit(1);
      //si tot es correcte fem la petició, cridem a la funció obtenirComarques i li pasem el nom de la provincia. ARA VE EL LIO:
      //Com que aquesta funció torna un future, amb el then diem: "QUAN" el future estiga ple, acabat, estaga completat--> vuic que fases algo amb el que em tornes(lambda) definim una funció anonima (comarques) I ES ARA QUEN LI DIGUEM QUE VOLEM FER AMB EL QUE ENS A TORNAT per aixo then(lambda{fes el que vulgues});
    } else {
      PeticionsHttp.obtenirComarques(args).then((comarques) {
        for (var nom in comarques) {
          print("\x1B[36m$nom\x1B[0m");
        }
      });
    }
    // Si la ordre es infocomarca mismo de lo mismo
  } else if (ordre == "infocomarca") {
    PeticionsHttp.obtenirInfoComarca(args).then((comarca) {
      print(comarca);
    }).catchError((error) {//capturem el error 404 de la classe PeticionsHttp
      print("\x1B[31m$error\x1B[0m");
      exit(1);
    });
  } else {
    print("\x1B[31mOrdre desconeguda\x1B[0m");
    exit(1);
  }

```


