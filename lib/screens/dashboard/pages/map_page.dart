import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  LatLng? _center;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  LatLng? _newMarkerLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // ... (previous code for location permission)
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle the case where the user has not enabled location services.
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case where the user denied or didn't grant permission.
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle the case where the user permanently denied location permission.
      return;
    }

    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _center = LatLng(position.latitude, position.longitude);
      _markers.add(Marker(
        markerId: MarkerId('userLocation'),
        position: _center!,
        infoWindow: InfoWindow(title: 'Your Location'),
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _addNewMarker(LatLng location) async {
    final markerId = MarkerId('newMarker');
    setState(() {
      _markers.add(Marker(
        markerId: markerId,
        position: location,
        infoWindow: InfoWindow(title: 'New Marker'),
      ));
      _newMarkerLocation = location;

      if (_center != null && _newMarkerLocation != null) {
        _getRouteAndDrawPolyline(_center!, _newMarkerLocation!);
      }
    });
  }

  Future<void> _getRouteAndDrawPolyline(LatLng from, LatLng to) async {
    // Fetch estimated travel time using Google Directions API
    final apiKey = 'AIzaSyB9_zPk9327zXx87L-zrS1wPvnx75PTlQg';
    final directionsResponse = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/directions/json?'
          'origin=${from.latitude},${from.longitude}'
          '&destination=${to.latitude},${to.longitude}'
          '&mode=driving'
          '&key=$apiKey'),
    );

    if (directionsResponse.statusCode == 200) {
      final directionsData = json.decode(directionsResponse.body);
      final String travelTime =
          directionsData['routes'][0]['legs'][0]['duration']['text'];

      final List<LatLng> points = _decodePolyline(directionsData);
      if (points.isNotEmpty) {
        final polylineId = PolylineId('route');
        final polyline = Polyline(
          polylineId: polylineId,
          color: Colors.blue,
          width: 5,
          points: points,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Estimated Travel Time: $travelTime'),
          ),
        );

        setState(() {
          _polylines.add(polyline);
        });
      }
    } else {
      print(
          "Directions API request failed with status code: ${directionsResponse.statusCode}");
    }
  }

  List<LatLng> _decodePolyline(Map<String, dynamic> directionsData) {
    final List<LatLng> points = [];
    if (directionsData.containsKey('routes')) {
      for (var route in directionsData['routes']) {
        if (route.containsKey('overview_polyline') &&
            route['overview_polyline'].containsKey('points')) {
          points.addAll(_convertToLatLng(route['overview_polyline']['points']));
        }
      }
    }
    return points;
  }

  List<LatLng> _convertToLatLng(String encoded) {
    final List<LatLng> points = [];
    final List<int> data = encoded.codeUnits;
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < data.length) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = data[index] - 63;
        index++;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = data[index] - 63;
        index++;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      final double latitude = lat / 1E5;
      final double longitude = lng / 1E5;
      points.add(LatLng(latitude, longitude));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        body: (_center == null)
            ? Center(child: CircularProgressIndicator())
            : GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center!,
                  zoom: 11.0,
                ),
                markers: _markers,
                polylines: _polylines,
                onTap: (LatLng location) {
                  _addNewMarker(location);
                },
              ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   late GoogleMapController mapController;
//   LatLng? _center;
//   Set<Marker> _markers = {};
//   Set<Polyline> _polylines = {};
//   LatLng? _newMarkerLocation;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Handle the case where the user has not enabled location services.
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Handle the case where the user denied or didn't grant permission.
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Handle the case where the user permanently denied location permission.
//       return;
//     }

//     final Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     setState(() {
//       _center = LatLng(position.latitude, position.longitude);
//       _markers.add(Marker(
//         markerId: MarkerId('userLocation'),
//         position: _center!,
//         infoWindow: InfoWindow(title: 'Your Location'),
//       ));
//     });
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   Future<void> _addNewMarker(LatLng location) async {
//     final markerId = MarkerId('newMarker');
//     setState(() {
//       _markers.add(Marker(
//         markerId: markerId,
//         position: location,
//         infoWindow: InfoWindow(title: 'New Marker'),
//       ));
//       _newMarkerLocation = location;

//       if (_center != null && _newMarkerLocation != null) {
//         _getRouteAndDrawPolyline(_center!, _newMarkerLocation!);
//       }
//     });
//   }

//   Future<void> _getRouteAndDrawPolyline(LatLng from, LatLng to) async {
//     final apiKey =
//         'AIzaSyB9_zPk9327zXx87L-zrS1wPvnx75PTlQg'; // Replace with your Google Maps API key
//     final directionsResponse = await http.get(
//       Uri.parse('https://maps.googleapis.com/maps/api/directions/json?'
//           'origin=${from.latitude},${from.longitude}'
//           '&destination=${to.latitude},${to.longitude}'
//           '&mode=driving'
//           '&key=$apiKey'),
//     );

//     if (directionsResponse.statusCode == 200) {
//       final directionsData = json.decode(directionsResponse.body);

//       print(
//           "Directions Response: $directionsData"); // Add this line for debugging

//       final List<LatLng> points = _decodePolyline(directionsData);

//       if (points.isNotEmpty) {
//         final polylineId = PolylineId('route');
//         final polyline = Polyline(
//           polylineId: polylineId,
//           color: Colors.blue,
//           width: 5,
//           points: points,
//         );
//         setState(() {
//           _polylines.add(polyline);
//         });
//       }
//     } else {
//       print(
//           "Directions API request failed with status code: ${directionsResponse.statusCode}");
//     }
//   }

//   List<LatLng> _decodePolyline(Map<String, dynamic> directionsData) {
//     final List<LatLng> points = [];
//     if (directionsData.containsKey('routes')) {
//       for (var route in directionsData['routes']) {
//         if (route.containsKey('overview_polyline') &&
//             route['overview_polyline'].containsKey('points')) {
//           points.addAll(_convertToLatLng(route['overview_polyline']['points']));
//         }
//       }
//     }
//     return points;
//   }

//   List<LatLng> _convertToLatLng(String encoded) {
//     final List<LatLng> points = [];
//     final List<int> data = encoded.codeUnits;
//     int index = 0;
//     int lat = 0;
//     int lng = 0;

//     while (index < data.length) {
//       int b;
//       int shift = 0;
//       int result = 0;

//       do {
//         b = data[index] - 63;
//         index++;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);

//       int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
//       lat += dlat;

//       shift = 0;
//       result = 0;

//       do {
//         b = data[index] - 63;
//         index++;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);

//       int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
//       lng += dlng;

//       final double latitude = lat / 1E5;
//       final double longitude = lng / 1E5;
//       points.add(LatLng(latitude, longitude));
//     }
//     return points;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: Colors.green[700],
//       ),
//       home: Scaffold(
//         body: (_center == null)
//             ? Center(child: CircularProgressIndicator())
//             : GoogleMap(
//                 onMapCreated: _onMapCreated,
//                 initialCameraPosition: CameraPosition(
//                   target: _center!,
//                   zoom: 11.0,
//                 ),
//                 markers: _markers,
//                 polylines: _polylines,
//                 onTap: (LatLng location) {
//                   _addNewMarker(location);
//                 },
//               ),
//       ),
//     );
//   }
// }
