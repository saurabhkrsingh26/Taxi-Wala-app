import 'dart:async';
import 'dart:typed_data';
import 'dart:ui'as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class YourMapWidget extends StatefulWidget {
  @override
  _YourMapWidgetState createState() => _YourMapWidgetState();
}

class _YourMapWidgetState extends State<YourMapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [];

  List<String> images = [
    "assets/images/cab.png", // Assuming images are stored in assets folder
    "assets/images/cab.png",
    "assets/images/cab.png",
    "assets/images/cab.png",
    "assets/images/cab.png",
  ];

  final List<LatLng> _latLang = [
    LatLng(26.83928000, 80.92313000),
    LatLng(26.83928000, 80.92313000),
    LatLng(26.765844, 83.364944),
    LatLng(25.45000000, 81.85000000),
    LatLng(12.97194000, 77.59369000)
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6941, 72.9734),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _latLang[i],
        icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: InfoWindow(title: "This is title $i"),
      ));
    }
    setState(() {}); // Update the state after loading markers
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Markers on Google Maps'),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_markers),
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            _controller.complete(controller);
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: YourMapWidget(),
  ));
}
