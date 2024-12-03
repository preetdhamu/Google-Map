import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConvertLatLongtoAddress extends StatefulWidget {
  const ConvertLatLongtoAddress({super.key});

  @override
  State<ConvertLatLongtoAddress> createState() =>
      _ConvertLatLongtoAddressState();
}

class _ConvertLatLongtoAddressState extends State<ConvertLatLongtoAddress> {
  LatLng latLng = LatLng(34.5645434, 76.12445534);
  String address = '';
  String ll = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latlong to Address Convertor"),
      ),
      body: Column(
        children: [
          Text("Current Location is : ${GeocodingPlatform.instance?.isPresent().asStream().first}"),
          Text("Address is : ${address}"),
          ElevatedButton(
              onPressed: () async {
                await GeocodingPlatform.instance
                    ?.placemarkFromCoordinates(
                        latLng.latitude, latLng.longitude)
                    .then(
                  (value) {
                    if (value.isNotEmpty) {
                      log(value.toString());
                      address = value[0].toString();
                      setState(() {});
                    }
                  },
                );
              },
              child: const Text("Convert")),
          Text("lat long is : $ll "),
          ElevatedButton(
              onPressed: () async {
                await GeocodingPlatform.instance
                    ?.locationFromAddress(address)
                    .then(
                  (value) {
                    if (value.isNotEmpty) {
                      log(value.toString());
                      ll = value[0].toString();
                      setState(() {});
                    }
                  },
                );
              },
              child: const Text("Convert"))
        ],
      ),
    );
  }
}
