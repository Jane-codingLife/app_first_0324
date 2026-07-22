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

class MapLocation {
  const MapLocation({required this.name, required this.position});

  final String name;
  final LatLng position;
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  // 測試 API 有沒有問題
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const List<MapLocation> _locations = [
    MapLocation(
      name: '逢甲大學',
      position: LatLng(24.180710834087648, 120.64694817420383),
    ),
    MapLocation(
      name: '台北101觀景台',
      position: LatLng(25.033973130532285, 121.56573255254136),
    ),
    MapLocation(
      name: '苗栗苑裡紫薇花園',
      position: LatLng(24.41055132370225, 120.6832707255704),
    ),
    MapLocation(
      name: '台中市立圖書館豐原分館(B棟)',
      position: LatLng(24.24142342766443, 120.71799235512394),
    ),
  ];

  static const double _normalZoom = 15;
  static const double _threeDimensionalZoom = 18;
  static const double _threeDimensionalTilt = 60;

  final ValueNotifier<int> _selectedLocationIndex = ValueNotifier<int>(0);

  GoogleMapController? _mapController;

  MapLocation get _seletedLocation {
    return _locations[_selectedLocationIndex.value];
  }

  @override
  void dispose() {
    super.dispose();
    _selectedLocationIndex.dispose();
    _mapController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google 地圖選擇清單'), centerTitle: true),
      body: Column(
        children: [
          _buildLocationSelector(),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(24.180710834087648, 120.64694817420383),
                zoom: _normalZoom,
              ),
              onMapCreated: _onMapCreated,
              mapType: MapType.normal,
              zoomControlsEnabled: true,
              compassEnabled: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showThreeDimensionalMap,
        icon: const Icon(Icons.view_in_ar),
        label: const Text('3D 地圖'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildLocationSelector() {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedLocationIndex,
        builder: (context, selectedIndex, child) {
          return DropdownButtonFormField<int>(
            initialValue: selectedIndex,
            decoration: const InputDecoration(
              labelText: '選擇地點',
              prefixIcon: Icon(Icons.location_on),
              border: OutlineInputBorder(),
            ),
            items: List.generate(_locations.length, (index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text(
                  _locations[index].name,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }),
            onChanged: (index) {
              if (index == null) {
                return;
              }
              _selectedLocationIndex.value = index;
              _moveToLocation(_locations[index]);
            },
          );
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _moveToLocation(MapLocation location) async {
    final controller = _mapController;

    if (controller == null) {
      return;
    }

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location.position, zoom: _normalZoom, tilt: 0),
      ),
    );
  }

  Future<void> _showThreeDimensionalMap() async {
    final controller = _mapController;

    if (controller == null) {
      return;
    }

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _seletedLocation.position,
          zoom: _threeDimensionalZoom,
          tilt: _threeDimensionalTilt,
        ),
      )
    );
  }
}
