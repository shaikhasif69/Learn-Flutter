// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class ConnectivityFeatures extends StatelessWidget {
//   final String widgetToShow;

//   const ConnectivityFeatures({super.key, required this.widgetToShow});

//   @override
//   Widget build(BuildContext context) {
//     switch (widgetToShow) {
//       case "NetworkStatus":
//         return const NetworkStatus();
//       case "SimpleApiCall":
//         return const SimpleApiCall();
//       case "OfflineDataCache":
//         return const OfflineDataCache();
//       default:
//         return const NetworkStatus();
//     }
//   }
// }

// class NetworkStatus extends StatefulWidget {
//   const NetworkStatus({super.key});

//   @override
//   State<NetworkStatus> createState() => _NetworkStatusState();
// }

// class _NetworkStatusState extends State<NetworkStatus> {
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

//   @override
//   void initState() {
//     super.initState();
//     _initConnectivity();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }

//   Future<void> _initConnectivity() async {
//     try {
//       final result = await _connectivity.checkConnectivity();
//       setState(() {
//         _connectionStatus =
//             result.isNotEmpty ? result.first : ConnectivityResult.none;
//       });
//     } catch (e) {
//       debugPrint('Could not check connectivity status: $e');
//     }
//   }

//   Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
//     setState(() {
//       _connectionStatus =
//           result.isNotEmpty ? result.first : ConnectivityResult.none;
//     });
//   }

//   String _getConnectionStatusText() {
//     switch (_connectionStatus) {
//       case ConnectivityResult.wifi:
//         return 'Connected to WiFi';
//       case ConnectivityResult.mobile:
//         return 'Connected to Mobile Network';
//       case ConnectivityResult.ethernet:
//         return 'Connected to Ethernet';
//       case ConnectivityResult.bluetooth:
//         return 'Connected via Bluetooth';
//       case ConnectivityResult.none:
//         return 'No Internet Connection';
//       default:
//         return 'Unknown Connection Status';
//     }
//   }

//   Color _getStatusColor() {
//     switch (_connectionStatus) {
//       case ConnectivityResult.none:
//         return Colors.red;
//       case ConnectivityResult.wifi:
//       case ConnectivityResult.mobile:
//       case ConnectivityResult.ethernet:
//       case ConnectivityResult.bluetooth:
//         return Colors.green;
//       default:
//         return Colors.orange;
//     }
//   }

//   IconData _getStatusIcon() {
//     switch (_connectionStatus) {
//       case ConnectivityResult.wifi:
//         return Icons.wifi;
//       case ConnectivityResult.mobile:
//         return Icons.signal_cellular_alt;
//       case ConnectivityResult.ethernet:
//         return Icons.lan;
//       case ConnectivityResult.bluetooth:
//         return Icons.bluetooth;
//       case ConnectivityResult.none:
//         return Icons.signal_wifi_off;
//       default:
//         return Icons.help;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Network Status Monitor'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               _getStatusIcon(),
//               size: 100,
//               color: _getStatusColor(),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               _getConnectionStatusText(),
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: _getStatusColor(),
//               ),
//             ),
//             const SizedBox(height: 40),
//             ElevatedButton.icon(
//               onPressed: _initConnectivity,
//               icon: const Icon(Icons.refresh),
//               label: const Text('Check Connection'),
//             ),
//             const SizedBox(height: 30),
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 'This demo monitors your network connection status in real-time. It will automatically update when your connection changes.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SimpleApiCall extends StatefulWidget {
//   const SimpleApiCall({super.key});

//   @override
//   State<SimpleApiCall> createState() => _SimpleApiCallState();
// }

// class _SimpleApiCallState extends State<SimpleApiCall> {
//   bool _isLoading = false;
//   String _responseText = 'Press the button to make an API call';
//   List<dynamic> _userData = [];
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final _connectivity = Connectivity();

//   @override
//   void initState() {
//     super.initState();
//     _checkConnectivity();
//   }

//   Future<void> _checkConnectivity() async {
//     try {
//       final result = await _connectivity.checkConnectivity();
//       setState(() {
//         _connectionStatus =
//             result.isNotEmpty ? result.first : ConnectivityResult.none;
//       });
//     } catch (e) {
//       debugPrint('Could not check connectivity status: $e');
//     }
//   }

//   Future<void> _fetchData() async {
//     await _checkConnectivity();

//     if (_connectionStatus == ConnectivityResult.none) {
//       setState(() {
//         _responseText = 'No internet connection. Please check your network.';
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _responseText = 'Loading data...';
//       _userData = [];
//     });

//     try {
//       final response = await http
//           .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           _userData = data;
//           _responseText = 'Data loaded successfully!';
//         });
//       } else {
//         setState(() {
//           _responseText =
//               'Error: ${response.statusCode} - ${response.reasonPhrase}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _responseText = 'Error: $e';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Simple API Call'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             color: _connectionStatus == ConnectivityResult.none
//                 ? Colors.red[100]
//                 : Colors.green[100],
//             width: double.infinity,
//             child: Row(
//               children: [
//                 Icon(
//                   _connectionStatus == ConnectivityResult.none
//                       ? Icons.signal_wifi_off
//                       : Icons.wifi,
//                   color: _connectionStatus == ConnectivityResult.none
//                       ? Colors.red
//                       : Colors.green,
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   _connectionStatus == ConnectivityResult.none
//                       ? 'Offline'
//                       : 'Online',
//                   style: TextStyle(
//                     color: _connectionStatus == ConnectivityResult.none
//                         ? Colors.red
//                         : Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: _isLoading ? null : _fetchData,
//                     icon: _isLoading
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Colors.white,
//                             ),
//                           )
//                         : const Icon(Icons.cloud_download),
//                     label: Text(_isLoading ? 'Fetching...' : 'Fetch User Data'),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 IconButton(
//                   onPressed: _checkConnectivity,
//                   icon: const Icon(Icons.refresh),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               _responseText,
//               style: TextStyle(
//                 color: _responseText.contains('Error')
//                     ? Colors.red
//                     : _responseText.contains('success')
//                         ? Colors.green
//                         : Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             child: _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : _userData.isEmpty
//                     ? const Center(
//                         child: Text('No data to display'),
//                       )
//                     : ListView.builder(
//                         itemCount: _userData.length,
//                         itemBuilder: (context, index) {
//                           final user = _userData[index];
//                           return Card(
//                             margin: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 child: Text('${user['id']}'),
//                               ),
//                               title: Text(user['name']),
//                               subtitle: Text(user['email']),
//                               trailing: const Icon(Icons.arrow_forward),
//                             ),
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class OfflineDataCache extends StatefulWidget {
//   const OfflineDataCache({super.key});

//   @override
//   State<OfflineDataCache> createState() => _OfflineDataCacheState();
// }

// class _OfflineDataCacheState extends State<OfflineDataCache> {
//   bool _isLoading = false;
//   bool _isOnline = true;
//   List<dynamic> _posts = [];
//   final _connectivity = Connectivity();
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

//   @override
//   void initState() {
//     super.initState();
//     _checkConnectivity();
//     _loadCachedData();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }

//   Future<void> _checkConnectivity() async {
//     try {
//       final result = await _connectivity.checkConnectivity();
//       setState(() {
//         _isOnline =
//             result.isNotEmpty && result.first != ConnectivityResult.none;
//       });
//     } catch (e) {
//       debugPrint('Could not check connectivity status: $e');
//     }
//   }

//   Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
//     setState(() {
//       _isOnline = result.isNotEmpty && result.first != ConnectivityResult.none;
//     });
//   }

//   Future<void> _loadCachedData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cachedData = prefs.getString('cached_posts');

//     if (cachedData != null) {
//       setState(() {
//         _posts = jsonDecode(cachedData);
//       });
//     }
//   }

//   Future<void> _fetchData() async {
//     setState(() {
//       _isLoading = true;
//     });

//     if (_isOnline) {
//       try {
//         final response = await http.get(
//             Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'));

//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           setState(() {
//             _posts = data;
//           });

//           // Cache the data
//           final prefs = await SharedPreferences.getInstance();
//           await prefs.setString('cached_posts', jsonEncode(data));
//           await prefs.setString('last_updated', DateTime.now().toString());
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Offline: Using cached data')),
//       );
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   Future<void> _clearCache() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('cached_posts');
//     await prefs.remove('last_updated');

//     setState(() {
//       _posts = [];
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Cache cleared')),
//     );
//   }

//   Future<String?> _getLastUpdated() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('last_updated');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Offline Data Cache'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             color: _isOnline ? Colors.green[100] : Colors.red[100],
//             child: Row(
//               children: [
//                 Icon(
//                   _isOnline ? Icons.cloud_done : Icons.cloud_off,
//                   color: _isOnline ? Colors.green : Colors.red,
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   _isOnline ? 'Online Mode' : 'Offline Mode',
//                   style: TextStyle(
//                     color: _isOnline ? Colors.green : Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Spacer(),
//                 FutureBuilder<String?>(
//                   future: _getLastUpdated(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData && snapshot.data != null) {
//                       final lastUpdated = DateTime.tryParse(snapshot.data!);
//                       if (lastUpdated != null) {
//                         return Text(
//                           'Last updated: ${lastUpdated.hour.toString().padLeft(2, '0')}:${lastUpdated.minute.toString().padLeft(2, '0')}',
//                           style: const TextStyle(fontSize: 12),
//                         );
//                       }
//                     }
//                     return const Text('Not yet updated');
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: _isLoading ? null : _fetchData,
//                     icon: _isLoading
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Colors.white,
//                             ),
//                           )
//                         : const Icon(Icons.refresh),
//                     label: Text(_isLoading ? 'Loading...' : 'Refresh Posts'),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 IconButton(
//                   onPressed: _clearCache,
//                   icon: const Icon(Icons.delete),
//                   tooltip: 'Clear Cache',
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : _posts.isEmpty
//                     ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               Icons.inbox,
//                               size: 80,
//                               color: Colors.grey,
//                             ),
//                             const SizedBox(height: 16),
//                             const Text(
//                               'No cached data found',
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             const SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: _fetchData,
//                               child: const Text('Fetch Data'),
//                             ),
//                           ],
//                         ),
//                       )
//                     : ListView.builder(
//                         itemCount: _posts.length,
//                         itemBuilder: (context, index) {
//                           final post = _posts[index];
//                           return Card(
//                             margin: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundColor: Colors.blue[200],
//                                         child: Text('${post['id']}'),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Expanded(
//                                         child: Text(
//                                           post['title'],
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Text(post['body']),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
// }
