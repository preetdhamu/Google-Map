import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetMyLocation extends StatefulWidget {
  const GetMyLocation({super.key});

  @override
  State<GetMyLocation> createState() => _GetMyLocationState();
}

class _GetMyLocationState extends State<GetMyLocation> {
  CameraPosition initialcampos =
      const CameraPosition(target: LatLng(37.0, 0), zoom: 14.0);
  LatLng currentLocation = LatLng(0, 0);

  Completer<GoogleMapController> _controller = Completer();

  List marker = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GoogleMap(
          markers: Set.from(marker),
          mapType: MapType.normal,
          onMapCreated: (controller) => _controller.complete(controller),
          initialCameraPosition: initialcampos),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Geolocator.requestPermission()
              .then(
            (value) async {},
          )
              .onError(
            (error, stackTrace) async {
              await Geolocator.requestPermission();
              print("Getting Error ");
            },
          );

          await Geolocator.getCurrentPosition().then((value) async {


            marker.add(Marker(
              markerId: const MarkerId('1'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(title: "My Current Location"),
            ));


            CameraPosition camerapos = CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 14.0);
            GoogleMapController controller1 = await _controller.future;


            controller1
                .animateCamera(CameraUpdate.newCameraPosition(camerapos));

            print("Working Properly ");
            setState(() {});
          }).onError(
            (error, stackTrace) {
              print("Getting Error ");
            },
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.home),
      ),
    ));
  }
}
