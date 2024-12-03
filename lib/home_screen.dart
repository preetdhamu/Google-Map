import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition cameraPos =
      CameraPosition(target: LatLng(29.903839, 73.877190), zoom: 16.4746);

  List<Marker> marker = [];
  List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(29.903839, 73.877190),
      infoWindow: InfoWindow(
        title: "My Location",
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(

            // mapType: MapType.satellite,
            // myLocationButtonEnabled: true,
            // myLocationEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            // compassEnabled: false,
            markers: Set.of(marker),
            onMapCreated: (controller) => _controller.complete(controller),
            initialCameraPosition: cameraPos),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        onPressed: () async {
          GoogleMapController controoler = await _controller.future;
          controoler.animateCamera(CameraUpdate.newCameraPosition(cameraPos));
          setState(() {
            
            
          });
        },
        child: Icon(Icons.home),
      ),
    );
  }
}
