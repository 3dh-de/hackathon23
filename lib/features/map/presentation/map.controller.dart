import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon23/features/map/domain/map.repository.dart';

import 'map.controller.state.dart';

class MapController extends StateNotifier<MapControllerState> {
  final MapRepository mapRepository;
  MapController(MapControllerState state, this.mapRepository) : super(state);

  void loadStations() async {
    final stations = await mapRepository.getStations();

    state = state.copyWith(stations: stations);
  }
}
