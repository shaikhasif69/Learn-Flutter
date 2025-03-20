import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationServices extends StatelessWidget {
  final String widgetToShow;

  const LocationServices({super.key, required this.widgetToShow});

  @override
  Widget build(BuildContext context) {
    switch (widgetToShow) {
      case "CurrentLocation":
        return const CurrentLocation();
      case "LocationTracking":
        return const LocationTracking();
      case "GeocodingExample":
        return const GeocodingExample();
      default:
        return const CurrentLocation();
    }
  }
}

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  bool _isLoading = false;
  String _locationMessage = 'Tap the button to get location';
  String _addressInfo = '';

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage =
            'Location services are disabled. Please enable the services';
      });
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = 'Location permissions are denied';
        });
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
            'Location permissions are permanently denied, we cannot request permissions.';
      });
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _locationMessage = 'Getting location...';
      _addressInfo = '';
    });

    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _locationMessage =
            'Latitude: ${position.latitude}\nLongitude: ${position.longitude}';
        _isLoading = false;
      });

      await _getAddressFromLatLng(position);
    } catch (e) {
      setState(() {
        _locationMessage = 'Error getting location: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        setState(() {
          _addressInfo = '${place.street}, ${place.subLocality}, '
              '${place.locality}, ${place.postalCode}, '
              '${place.country}';
        });
      }
    } catch (e) {
      setState(() {
        _addressInfo = 'Error getting address: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Location'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _locationMessage,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      if (_addressInfo.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 10),
                        const Text(
                          'Address:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _addressInfo,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _getCurrentLocation,
                icon: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location),
                label: Text(_isLoading
                    ? 'Getting Location...'
                    : 'Get Current Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationTracking extends StatefulWidget {
  const LocationTracking({super.key});

  @override
  State<LocationTracking> createState() => _LocationTrackingState();
}

class _LocationTrackingState extends State<LocationTracking> {
  bool _isTracking = false;
  List<Position> _locationHistory = [];
  late Stream<Position> _positionStream;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    return true;
  }

  void _startTracking() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      return;
    }

    setState(() {
      _isTracking = true;
    });

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );

    _positionStream.listen((Position position) {
      setState(() {
        _locationHistory.add(position);
      });
    });
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
    });
  }

  void _clearHistory() {
    setState(() {
      _locationHistory.clear();
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Tracking'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _isTracking ? null : _startTracking,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Tracking'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isTracking ? _stopTracking : null,
                  icon: const Icon(Icons.stop),
                  label: const Text('Stop Tracking'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _locationHistory.isEmpty ? null : _clearHistory,
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: _isTracking ? Colors.green[100] : Colors.grey[200],
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: _isTracking ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  _isTracking ? 'Tracking is active' : 'Tracking is inactive',
                  style: TextStyle(
                    color: _isTracking ? Colors.green[800] : Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _locationHistory.isEmpty
                ? const Center(
                    child: Text(
                      'No location data yet.\nTap "Start Tracking" to begin collecting location data.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: _locationHistory.length,
                    itemBuilder: (context, index) {
                      final position =
                          _locationHistory[_locationHistory.length - 1 - index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text('${_locationHistory.length - index}'),
                          ),
                          title: Text(
                            'Lat: ${position.latitude.toStringAsFixed(6)}, Lng: ${position.longitude.toStringAsFixed(6)}',
                          ),
                          subtitle: Text(
                            'Time: ${_formatDateTime(position.timestamp)}',
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class GeocodingExample extends StatefulWidget {
  const GeocodingExample({super.key});

  @override
  State<GeocodingExample> createState() => _GeocodingExampleState();
}

class _GeocodingExampleState extends State<GeocodingExample> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  String _geocodeResult = '';
  bool _isLoading = false;

  Future<void> _geocodeAddress() async {
    if (_addressController.text.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _geocodeResult = 'Searching...';
    });

    try {
      final locations = await locationFromAddress(_addressController.text);

      if (locations.isNotEmpty) {
        final location = locations.first;
        setState(() {
          _geocodeResult =
              'Latitude: ${location.latitude}\nLongitude: ${location.longitude}';
        });
      } else {
        setState(() {
          _geocodeResult = 'No results found';
        });
      }
    } catch (e) {
      setState(() {
        _geocodeResult = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _reverseGeocode() async {
    if (_latController.text.isEmpty || _lngController.text.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _geocodeResult = 'Searching...';
    });

    try {
      final double latitude = double.parse(_latController.text);
      final double longitude = double.parse(_lngController.text);

      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        setState(() {
          _geocodeResult = 'Address: ${place.street}, ${place.subLocality}, '
              '${place.locality}, ${place.postalCode}, '
              '${place.country}';
        });
      } else {
        setState(() {
          _geocodeResult = 'No results found';
        });
      }
    } catch (e) {
      setState(() {
        _geocodeResult = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geocoding Example'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Forward Geocoding',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Convert address to coordinates',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          hintText: 'Enter an address to get coordinates',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.map),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _geocodeAddress,
                        icon: const Icon(Icons.search),
                        label: const Text('Geocode Address'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reverse Geocoding',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Convert coordinates to address',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _latController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Latitude',
                                hintText: 'Enter latitude',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _lngController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Longitude',
                                hintText: 'Enter longitude',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _reverseGeocode,
                        icon: const Icon(Icons.search),
                        label: const Text('Reverse Geocode'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Result',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _geocodeResult.isEmpty
                                    ? 'No results yet'
                                    : _geocodeResult,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addressController.text = "Statue of Liberty, New York";
                },
                child: const Text('Example: Statue of Liberty'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _latController.text = "40.7484";
                  _lngController.text = "-73.9857";
                },
                child: const Text('Example: Empire State Building Coordinates'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
