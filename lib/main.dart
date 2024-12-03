import 'package:flutter/material.dart';
import 'package:google_mp/get_my_location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetMyLocation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
