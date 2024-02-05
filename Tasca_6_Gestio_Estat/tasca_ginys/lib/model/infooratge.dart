class InfoOratge {
  String? temperatura;
  String? velocitatVent;
  String? direccioVent;
  String? codiOratge;

  InfoOratge({
    this.temperatura,
    this.velocitatVent,
    this.direccioVent,
    this.codiOratge,
  });

  InfoOratge.fromJSON(Map<String, dynamic> objecteJSON) {
    temperatura = objecteJSON["current_weather"]['temperature'].toString();
    velocitatVent = objecteJSON["current_weather"]['windspeed'].toString();
    direccioVent = objecteJSON["current_weather"]['winddirection'].toString();
    codiOratge = objecteJSON["current_weather"]['weathercode'].toString();
  }

  @override
  String toString() =>
      "$temperatura; $velocitatVent; $direccioVent; $codiOratge";
}
