import 'dart:convert';

import 'package:hackathon_app/model/station.dart';
import 'package:http/http.dart' as http;

class StationService{
  Future<List<Station>> fetchAllStations() async {
    final response = await http
        .get(Uri.parse('http://kobudo.3dh.de/pegelmessstationen/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return _parseStations(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  List<Station> _parseStations(String jsonStr) {
    final List<dynamic> data = jsonDecode(jsonStr);
    final List<Station> stations = data.map((e) => Station.fromJson(e)).toList();
    return stations;
  }

}