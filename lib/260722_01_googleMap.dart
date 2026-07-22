import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

// StatelessWidget 不會變更的 UI
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),

      home: const MapPage(),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  static const LatLng _initialPosition = LatLng(
    24.18047593466162, 120.64660485144904
  );

  // 縮放比例
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: _initialPosition,
    zoom: 15.0,
  );

  // 測試 API 有沒有問題
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google 地圖'),),
      body: const GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
      ),
    );
  }
}
