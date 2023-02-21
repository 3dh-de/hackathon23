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
}
