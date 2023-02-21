import '../domain/map.entity.dart';

abstract class MapDatasource {
  Future<List<MapEntity>> getStations();
}
