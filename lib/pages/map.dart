import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon_app/model/station.dart';
import 'package:hackathon_app/model/station_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  final StationService stationService = StationService();

  late Future<List<Station>> stations;

  static const CameraPosition _kInitialPos = CameraPosition(
    target: LatLng(53.629593, 11.414763),
    zoom: 10.0,
  );

  bool _isFActionButtonVisible = false;

  Future<void> _resetToInitialPos() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kInitialPos));
  }

  Future<void> _moveToPosition(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: latLng,
        zoom: 10.0
        ),
      ),
    );
  }

  Widget _createListTiles(Future<List<Station>> stations) {
    return FutureBuilder<List<Station>>(
      future: stations,
      builder: (BuildContext context, AsyncSnapshot<List<Station>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final List<Station> stations = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: stations.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Station ${stations.elementAt(index).ort}'),
                onTap: (){
                  var koordinaten = stations.elementAt(index).koordinaten;
                  _moveToPosition(LatLng(koordinaten.first, koordinaten.last));
                  Navigator.of(context).pop();
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void initState() {
    setState(() {
      stations = stationService.fetchAllStations();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Map"),
      ),
      drawer: Drawer(
        elevation: 10.0,
        child: _createListTiles(stations),
      ),
      body: FutureBuilder<List<Station>>(
        future: stations,
        builder: (BuildContext context, AsyncSnapshot<List<Station>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the future is still waiting for data, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If the future has an error, show an error message
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If the future has no data or an empty list, show a message
            return const Text('No data found');
          } else {
            // If the future has data, map the WaterSensors to markers on a Google Map
            Set<Marker> markers = snapshot.data!.map((station) {
              return Marker(
                markerId: MarkerId(station.kennung.toString()),
                position: LatLng(station.koordinaten.first, station.koordinaten.last),
                infoWindow: InfoWindow(
                  title: station.ort,
                  snippet: "${station.akkustand}%",
                ),
                // Other marker properties such as icon, info window, etc.
            );
            }).toSet();

            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kInitialPos,
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            );
          }
        },
      ),
      floatingActionButton: Visibility(
        visible: _isFActionButtonVisible,
        child: FloatingActionButton.extended(
          onPressed: _resetToInitialPos,
          label: const Text('Reset'),
          icon: const Icon(Icons.undo),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
