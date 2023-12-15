class Comarca {
  String comarca;
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

  Comarca.fromJSON(Map<String, dynamic> objecteJSON)
      : comarca = objecteJSON['comarca']!,
        capital = objecteJSON['capital'],
        poblacio = objecteJSON['poblacio'],
        img = objecteJSON['img'],
        desc = objecteJSON['desc'],
        latitud = objecteJSON['latitud']?.toDouble(),
        longitud = objecteJSON['longitud']?.toDouble();

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
}
