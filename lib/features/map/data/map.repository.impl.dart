import 'package:hackathon23/features/map/domain/map.entity.dart';

import '../domain/map.repository.dart';
import 'map.datasource.dart';

class MapRepositoryImpl implements MapRepository {
  final MapDatasource mapRemoteDataSource;

  MapRepositoryImpl({required this.mapRemoteDataSource});

  @override
  Future<List<MapEntity>> getStations() async {
    // TODO: Add station state and error handling
    return await mapRemoteDataSource.getStations();
  }
}
