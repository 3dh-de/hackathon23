import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
  Future<Map<String, dynamic>> getStations() async {
    try {
      final response = await httpClient.get('/pegelmessstationen');
      if (HttpStatus.ok == response.statusCode) {
        return response.data;
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
