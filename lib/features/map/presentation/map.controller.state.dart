import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/map.entity.dart';

part 'map.controller.state.freezed.dart';

@freezed
class MapControllerState with _$MapControllerState {
  factory MapControllerState({
    @Default(AsyncData([])) AsyncValue<List<MapEntity>> stations,
  }) = _MapControllerState;
}
