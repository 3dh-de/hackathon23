import 'package:hackathon23/features/map/domain/map.entity.dart';

abstract class MapRepository {
  Future<List<MapEntity>> getStations();
}
