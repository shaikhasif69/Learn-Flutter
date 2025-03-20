import 'package:flutter/material.dart';
import 'package:learn_flutter/functionalWidgets/communicationWidgets.dart';
import 'package:learn_flutter/functionalWidgets/connectivityFeatures.dart';
import 'package:learn_flutter/functionalWidgets/dataStorageWidgets.dart';
import 'package:learn_flutter/functionalWidgets/locationServicesWidget.dart';
import 'package:learn_flutter/functionalWidgets/mediaCaptureWidgets.dart';
import 'package:learn_flutter/functionalWidgets/sensorAndAnimation.dart';

class FunctionalComponentsNavigator extends StatefulWidget {
  const FunctionalComponentsNavigator({super.key});

  @override
  State<FunctionalComponentsNavigator> createState() =>
      _FunctionalComponentsNavigatorState();
}

class _FunctionalComponentsNavigatorState
    extends State<FunctionalComponentsNavigator> {
  final Map<String, List<Map<String, String>>> _componentCategories = {
    'Media': [
      {'name': 'Take Photo', 'component': 'TakePhoto'},
      {'name': 'Pick Single Image', 'component': 'PickSingleImage'},
      {'name': 'Pick Multiple Images', 'component': 'PickMultipleImages'},
      {'name': 'Record Video', 'component': 'RecordVideo'},
      {'name': 'Play Video', 'component': 'PlayVideo'},
    ],
    'Communication': [
      {'name': 'Phone Caller', 'component': 'PhoneCaller'},
      {'name': 'Email Sender', 'component': 'EmailSender'},
      {'name': 'Web Browser', 'component': 'WebBrowser'},
      {'name': 'SMS Sender', 'component': 'SMSSender'},
    ],
    'Data Storage': [
      {'name': 'User Preferences', 'component': 'UserPreferences'},
      {'name': 'Simple Notepad', 'component': 'SimpleNotepad'},
      {'name': 'Simple Counter', 'component': 'SimpleCounter'},
      {'name': 'Theme Switch', 'component': 'ThemeSwitch'},
    ],
    'Location': [
      {'name': 'Current Location', 'component': 'CurrentLocation'},
      {'name': 'Location Tracking', 'component': 'LocationTracking'},
      {'name': 'Geocoding', 'component': 'GeocodingExample'},
    ],
    'Sensors & Animations': [
      {'name': 'Accelerometer', 'component': 'AccelerometerDemo'},
      {'name': 'Gyroscope', 'component': 'GyroscopeDemo'},
      {'name': 'Animations', 'component': 'SimpleAnimations'},
    ],
    'Connectivity': [
      {'name': 'Network Status', 'component': 'NetworkStatus'},
      {'name': 'API Call', 'component': 'SimpleApiCall'},
      {'name': 'Offline Cache', 'component': 'OfflineDataCache'},
    ],
  };

  void _navigateToComponent(String category, String component) {
    Widget widget;

    switch (category) {
      case 'Media':
        widget = MediaCapture(widgetToShow: component);
        break;
      case 'Communication':
        widget = CommunicationFeatures(widgetToShow: component);
        break;
      case 'Data Storage':
        widget = DataStorage(widgetToShow: component);
        break;
      case 'Location':
        widget = LocationServices(widgetToShow: component);
        break;
      case 'Sensors & Animations':
        widget = SensorsAndAnimations(widgetToShow: component);
        break;
      // case 'Connectivity':
      //   widget = ConnectivityFeatures(widgetToShow: component);
      //   break;
      default:
        widget = const Scaffold(
          body: Center(child: Text('Component not found')),
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Functional Components'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _componentCategories.length,
        itemBuilder: (context, categoryIndex) {
          final categoryName =
              _componentCategories.keys.elementAt(categoryIndex);
          final components = _componentCategories[categoryName]!;

          return ExpansionTile(
            leading: _getCategoryIcon(categoryName),
            title: Text(
              categoryName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: components.map((component) {
              return ListTile(
                leading: const Icon(Icons.arrow_right),
                title: Text(component['name']!),
                onTap: () => _navigateToComponent(
                  categoryName,
                  component['component']!,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Icon _getCategoryIcon(String category) {
    switch (category) {
      case 'Media':
        return const Icon(Icons.camera_alt);
      case 'Communication':
        return const Icon(Icons.call);
      case 'Data Storage':
        return const Icon(Icons.storage);
      case 'Location':
        return const Icon(Icons.location_on);
      case 'Sensors & Animations':
        return const Icon(Icons.sensors);
      case 'Connectivity':
        return const Icon(Icons.wifi);
      default:
        return const Icon(Icons.category);
    }
  }
}
