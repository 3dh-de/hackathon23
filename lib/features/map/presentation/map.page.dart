import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon23/features/map/shared/map.providers.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends ConsumerWidget {
  final MapController _mapController = MapController();
  MapPage({Key? key}) : super(key: key) {
    _mapController.mapEventStream.listen((event) {
      if (event is MapEventDoubleTapZoom) {
        debugPrint('mapEvent: ${event.targetZoom}');
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    Future(() => ref.read(MapProviders.mapController.notifier).loadStations());
    // ref.read(MapProviders.mapController.notifier).loadStations();
    // mapControllerNotifier.loadStations();
    final mapControllerState = ref.watch(MapProviders.mapController);

    mapControllerState.stations
        .whenData((value) => debugPrint('data recieved'));

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
              zoom: 13,
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
                markers: [
                  Marker(
                    point: LatLng(53.565477494524934, 11.389190554651758),
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
                    },
                  ),
                ],
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
