class Provincia {
  late String nom;
  String? imatge;

  // Constructor amb arguments amb nom,
  // obligatoris (nom) i opcionals (imatge)

  //constructor per defecte
  Provincia({required this.nom, this.imatge});

  //constructor DESDE UN JSON, vist també al curs Api en Nodejs.
  Provincia.fromJSON(Map<String, dynamic> objecteJSON) {
    nom = objecteJSON["provincia"] ?? "";
    imatge = objecteJSON["img"] ?? "";
  }

  @override
  String toString() => "$nom; $imatge";
}
