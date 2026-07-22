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

  static const List<String> _mapTypeLabels = ['街道圖', '衛星影像', '地形圖', '混合地圖'];

  static const List<MapType> _mapTypes = [
    MapType.normal,
    MapType.satellite,
    MapType.terrain,
    MapType.hybrid,
  ];

  // 範圍 - 方形
  static const List<LatLng> _topiciRoutoPoints = [
    LatLng(25.037, 121.567),
    LatLng(25.037, 121.560),
    LatLng(25.029, 121.563),
    LatLng(25.029, 121.567),
    LatLng(25.037, 121.567),
  ];

  GoogleMapController? _mapController;

  int _selectedLocationIndex = 0;
  int _selectedMapTypeIndex = 0;
  bool _showMapObjects = false;

  Set<Marker> get _markers {
    if (!_showMapObjects) {
      return const {};
    }
    return _locations.asMap().entries.map((entry) {
      final int index = entry.key;
      final MapLocation location = entry.value;

      return Marker(
        markerId: MarkerId('location_$index'),
        position: location.position,
        infoWindow: InfoWindow(
          title: location.name,
          onTap: () {
            _hideMarkerInfoWindow(index);
          },
        ),
      );
    }).toSet();
  }

  Set<Polyline> get _polylines {
    if (!_showMapObjects) {
      return const {};
    }
    return {
      const Polyline(
        polylineId: PolylineId('台北_route'),
        points: _topiciRoutoPoints,
        color: Colors.blue,
        width: 8,
      ),
    };
  }

  @override
  void dispose() {
    super.dispose();
    _mapController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google 地圖類型選擇'), centerTitle: true),
      body: Column(
        children: [
          _buildMapOptionPanel(),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _locations.first.position,
                zoom: 15,
              ),
              onMapCreated: _onMapCreated,
              mapType: _mapTypes[_selectedMapTypeIndex],
              markers: _markers,
              polylines: _polylines,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggleMapObjects,
        icon: Icon(
          _showMapObjects ? Icons.location_off : Icons.add_location_alt,
        ),
        label: Text(_showMapObjects ? '隱藏地標和路徑' : '顯示地標和路徑'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMapOptionPanel() {
    return Padding(
      padding: const EdgeInsetsGeometry.all(12),
      child: Row(
        children: [
          Expanded(child: _buildLocationDropdown()),
          const SizedBox(width: 12),
          Expanded(child: _buildMapTypeDropdown()),
        ],
      ),
    );
  }

  Widget _buildLocationDropdown() {
    return DropdownButtonFormField(
      initialValue: _selectedLocationIndex,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: '選擇地點',
        border: OutlineInputBorder(),
      ),
      items: List.generate(_locations.length, (index) {
        return DropdownMenuItem(
          value: index,
          child: Text(_locations[index].name, overflow: TextOverflow.ellipsis),
        );
      }),
      onChanged: (int? index) {
        if (index == null) {
          return;
        }
        _changeLocation(index);
      },
    );
  }

  Widget _buildMapTypeDropdown() {
    return DropdownButtonFormField(
      initialValue: _selectedMapTypeIndex,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: '地圖類型',
        border: OutlineInputBorder(),
      ),
      items: List.generate(_mapTypeLabels.length, (index) {
        return DropdownMenuItem(
          value: index,
          child: Text(_mapTypeLabels[index], overflow: TextOverflow.ellipsis),
        );
      }),
      onChanged: (int? index) {
        if (index == null) {
          return;
        }
        setState(() {
          _selectedMapTypeIndex = index;
        });
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _changeLocation(int index) async {
    setState(() {
      _selectedLocationIndex = index;
    });

    final GoogleMapController? controller = _mapController;
    if (controller == null) {
      return;
    }
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _locations[index].position, zoom: 15),
      ),
    );
  }

  Future<void> _hideMarkerInfoWindow(int index) async {
    final GoogleMapController? controller = _mapController;

    if (controller == null) {
      return;
    }

    await controller.hideMarkerInfoWindow(MarkerId('location_$index'));
  }

  void _toggleMapObjects() {
    setState(() {
      _showMapObjects = !_showMapObjects;
    });
  }
}
