import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hackathon23/features/map/domain/map.entity.dart';

import '../../app/domain/configuration.dart';
import 'map.datasource.dart';

class MapRemoteDatasource implements MapDatasource {
  final Configuration configuration;
  final Dio httpClient;

  MapRemoteDatasource({
    required this.configuration,
    required this.httpClient,
  });

  @override
  Future<List<MapEntity>> getStations() async {
    try {
      final Response<String> response =
          await httpClient.get('/pegelmessstationen/');
      if (HttpStatus.ok == response.statusCode && null != response.data) {
        final result = response.data!;

        final mapEntities = List<MapEntity>.from(
            jsonDecode(result).map((x) => MapEntity.fromMap(x)));
        return mapEntities;
      }

      throw Exception(
        'HTTP Status ${response.statusCode}, ${response.statusMessage}',
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
