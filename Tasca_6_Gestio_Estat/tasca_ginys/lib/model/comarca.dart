class Comarca {
  //Amb late estem dientli que inicialitzarem la variable més tart, es quan en java es quixa i ens deia que la variable no esta inicialitza i lo posavem abans un camp buit Sting nom = ""; i després ja la gastevem. Millor posar aixo perque al ser un camp raquerit no pot ser null i per aixo el late i no la interrogant.
  late String comarca;
  String? capital;
  String? poblacio;
  String? img;
  String? desc;
  double? latitud;
  double? longitud;

  Comarca({
    required this.comarca,
    this.capital,
    this.poblacio,
    this.img,
    this.desc,
    this.latitud,
    this.longitud,
  });

  Comarca.fromJSON(Map<String, dynamic> objecteJSON) {
    comarca = objecteJSON['comarca'] ?? "";
    capital = objecteJSON['capital'] ?? "";
    poblacio = objecteJSON['poblacio'] ?? "";
    img = objecteJSON['img'] ?? "";
    desc = objecteJSON['desc'] ?? "";
    latitud = objecteJSON['latitud']?.toDouble();
    longitud = objecteJSON['longitud']?.toDouble();
  }

  @override
  String toString() =>
      "$comarca; $capital; $poblacio; $img; $desc; $latitud; $longitud";
}
