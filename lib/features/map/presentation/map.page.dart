import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../shared/map.providers.dart';

class MapPage extends ConsumerStatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _mapController.mapEventStream.listen((event) {
      if (event is MapEventDoubleTapZoom) {
        debugPrint('mapEvent: ${event.targetZoom}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mapControllerState = ref.watch(MapProviders.mapController);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Hackathon \'23'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(53.59749511484229, 11.404999125376248),
              zoom: 8,
            ),
            children: [
              TileLayer(
                maxZoom: 20,
                minNativeZoom: 6,
                maxNativeZoom: 18,
                wmsOptions: WMSTileLayerOptions(
                  baseUrl: 'https://sgx.geodatenzentrum.de/wms_basemapde?',
                  layers: [
                    'de_basemapde_web_raster_farbe',
                    // 'de_basemapde_web_raster_grau'
                  ],
                ),
              ),
              MarkerLayer(
                markers: mapControllerState.stations
                    .map((e) => Marker(
                        point: e.koordinaten!,
                        builder: (_) {
                          return Platform.isIOS
                              ? const Icon(
                                  CupertinoIcons.location_solid,
                                  size: 24,
                                )
                              : const Icon(
                                  Icons.location_on_rounded,
                                  size: 24,
                                  color: Colors.blueAccent,
                                );
                        }))
                    .toList(),
              ),
              Positioned(
                right: 25,
                bottom: 20,
                child: Text(
                  '© basemap.de / BKG ${DateTime.now().year}',
                  style: textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
