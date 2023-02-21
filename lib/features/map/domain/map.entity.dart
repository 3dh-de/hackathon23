import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'map.entity.freezed.dart';

@freezed
class MapEntity with _$MapEntity {
  factory MapEntity({
    @Default(0) int akkustand,
    @Default(0) int aktuellerMessstand,
    @Default(null) DateTime? ersteMessung,
    @Default(false) bool geraeteStatus,
    @Default('') String gewaesserpegelart,
    @Default(0) int kennung,
    @Default(null) LatLng? koordinaten,
    @Default(null) DateTime? letzteMessung,
    @Default(0) int maxMessstand,
    @Default(0) int minMessstand,
    @Default('') String ort,
    @Default(0) int temperatur,
  }) = _MapEntity;

  factory MapEntity.fromMap(Map<String, dynamic> map) {
    return MapEntity(
      akkustand: map['akkustand'],
      aktuellerMessstand: map['aktueller_messstand'],
      ersteMessung: DateTime.tryParse(map['erste_messung']),
      geraeteStatus: map['geraete_status'],
      gewaesserpegelart: map['gewaesserpegelart'],
      kennung: map['kennung'],
      koordinaten: LatLng(map['koordinaten'][0], map['koordinaten'][1]),
      letzteMessung: DateTime.tryParse(map['letzte_messung']),
      maxMessstand: map['max_messstand'],
      minMessstand: map['min_messstand'],
      ort: map['ort'],
      temperatur: map['temperatur'],
    );
  }
}
