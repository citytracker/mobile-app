import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:minhacidademeuproblema/core/utils/utils.dart';
import 'package:minhacidademeuproblema/domain/data/problem.dart';
import 'package:minhacidademeuproblema/services/service_problem.dart';
import 'package:minhacidademeuproblema/widgets/problem_map.dart';

class PageMapProblems extends StatefulWidget {
  const PageMapProblems({super.key});

  @override
  State<PageMapProblems> createState() => _PageMapProblemsState();
}

class _PageMapProblemsState extends State<PageMapProblems> {
  MapController mapController = MapController();

  ServiceProblem _service = ServiceProblem();
  final PopupController _popupLayerController = PopupController();

  var latLog = LatLng(51.5, -0.09);

  List<Problem> _problems = List.empty();
  List<Marker> _markers = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        var result = await Utils.determinePosition();
        setState(() {
          latLog = LatLng(result.latitude, result.longitude);
          mapController.move(latLog, 10);
        });
      } catch (e) {}

      getProblems();
    });
  }

  getProblems() {
    _service.getProblems().then((value) {
      setState(() {
        _problems = value;
        _markers = value
            .map((e) => Marker(
                  key: ObjectKey(e),
                  point: LatLng(e.lat, e.log),
                  child: const Icon(
                    Icons.report_problem,
                    size: 30,
                    color: Colors.red,
                  ),
                ))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa de problemas")),
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
                  onTap: (_, __) => _popupLayerController.hideAllPopups(),
                  interactionOptions: InteractionOptions(),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  // MarkerLayer(markers: _markers),
                  PopupMarkerLayer(
                    options: PopupMarkerLayerOptions(
                        popupController: _popupLayerController,
                        markers: _markers,
                        popupDisplayOptions: PopupDisplayOptions(
                          builder: (p0, p1) {
                            var item = (p1.key as ObjectKey).value as Problem;

                            return ProblemMap(problem: item);
                          },
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
