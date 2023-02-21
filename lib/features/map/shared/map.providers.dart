import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon23/features/app/shared/app.providers.dart';
import 'package:hackathon23/features/map/domain/map.entity.dart';
import 'package:hackathon23/features/map/presentation/map.controller.state.dart';

import '../data/map.datasource.dart';
import '../data/map.remote.datasource.dart';
import '../data/map.repository.impl.dart';
import '../domain/map.repository.dart';
import '../presentation/map.controller.dart';

class MapProviders {
  // Data
  static final Provider<Dio> httpClient = Provider((ref) {
    final configuration = ref.read(AppProviders.configuration);
    return Dio(BaseOptions(baseUrl: configuration.apiUrl));
  });

  static final Provider<MapDatasource> mapRemoteDatasource = Provider(
    (ref) => MapRemoteDatasource(
      configuration: ref.read(AppProviders.configuration),
      httpClient: ref.read(httpClient),
    ),
  );

  // Domain
  static final Provider<MapRepository> mapRepository = Provider((ref) =>
      MapRepositoryImpl(mapRemoteDataSource: ref.read(mapRemoteDatasource)));

  static final FutureProvider<List<MapEntity>> getStations = FutureProvider(
      (ref) async => await ref.read(mapRepository).getStations());
  // Presentation
  static final StateNotifierProvider<MapController, MapControllerState>
      mapController = StateNotifierProvider((ref) {
    final stations = ref.watch(getStations);
    return MapController(
      MapControllerState(stations: stations.value ?? []),
      ref.read(mapRepository),
    );
  });
}
