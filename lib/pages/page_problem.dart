import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:minhacidademeuproblema/core/utils/utils.dart';

class PageProblem extends StatefulWidget {
  const PageProblem({super.key});

  @override
  State<PageProblem> createState() => _PageProblemState();
}

class _PageProblemState extends State<PageProblem> {
  final mapController = MapController();

  var latLog = LatLng(51.5, -0.09);

  List<Marker> _markers = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        var result = await Utils.determinePosition();
        setState(() {
          latLog = LatLng(result.latitude, result.longitude);
          _markers.add(Marker(
              point: latLog,
              child: const Icon(
                Icons.report,
                size: 50,
              )));
          mapController.move(latLog, 10);
        });
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Definir localização')),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: () {
            Navigator.pushNamed(context, "/problema_form", arguments: latLog);
          }),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: latLog,
                  initialZoom: 5,
                  maxZoom: 20,
                  minZoom: 3,
                  interactionOptions: InteractionOptions(),
                  onLongPress: (tapPosition, point) {
                    setState(() {
                      _markers.clear();
                      latLog = point;
                      _markers.add(Marker(
                          point: point,
                          child: const Icon(
                            Icons.report,
                            size: 50,
                          )));
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(markers: _markers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
