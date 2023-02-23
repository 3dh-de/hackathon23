class Station {
  int maxMessstand;
  bool geraeteStatus;
  String letzteMessung;
  String gewaesserpegelart;
  String ort;
  int aktuellerMessstand;
  List<double> koordinaten;
  int temperatur;
  String ersteMessung;
  int kennung;
  int akkustand;
  int minMessstand;

  Station({
    required this.maxMessstand,
    required this.geraeteStatus,
    required this.letzteMessung,
    required this.gewaesserpegelart,
    required this.ort,
    required this.aktuellerMessstand,
    required this.koordinaten,
    required this.temperatur,
    required this.ersteMessung,
    required this.kennung,
    required this.akkustand,
    required this.minMessstand,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      maxMessstand: json['max_messstand'],
      geraeteStatus: json['geraete_status'],
      letzteMessung: json['letzte_messung'],
      gewaesserpegelart: json['gewaesserpegelart'],
      ort: json['ort'],
      aktuellerMessstand: json['aktueller_messstand'],
      koordinaten: List<double>.from(json['koordinaten']),
      temperatur: json['temperatur'],
      ersteMessung: json['erste_messung'],
      kennung: json['kennung'],
      akkustand: json['akkustand'],
      minMessstand: json['min_messstand'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['max_messstand'] = maxMessstand;
    data['geraete_status'] = geraeteStatus;
    data['letzte_messung'] = letzteMessung;
    data['gewaesserpegelart'] = gewaesserpegelart;
    data['ort'] = ort;
    data['aktueller_messstand'] = aktuellerMessstand;
    data['koordinaten'] = koordinaten;
    data['temperatur'] = temperatur;
    data['erste_messung'] = ersteMessung;
    data['kennung'] = kennung;
    data['akkustand'] = akkustand;
    data['min_messstand'] = minMessstand;
    return data;
  }
}
