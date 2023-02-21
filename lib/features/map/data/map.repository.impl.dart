import 'package:hackathon23/features/map/domain/map.entity.dart';

import '../domain/map.repository.dart';
import 'map.datasource.dart';

class MapRepositoryImpl implements MapRepository {
  final MapDatasource mapRemoteDataSource;

  MapRepositoryImpl({required this.mapRemoteDataSource});

  @override
  Future<List<MapEntity>> getStations() async {
    final stations = await mapRemoteDataSource.getStations();

    return [];
  }
}
