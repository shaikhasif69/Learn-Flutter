import 'package:flutter/material.dart';

class SimpleState extends StatefulWidget {
  const SimpleState({super.key});

  @override
  State<SimpleState> createState() => _SimpleStateState();
}

class _SimpleStateState extends State<SimpleState> {
  // Variables for counter
  int _counter = 0;

  // Variables for color changer
  Color _boxColor = Colors.blue;
  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];
  int _colorIndex = 0;

  // Variables for form
  final TextEditingController _nameController = TextEditingController();
  String _displayName = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _nameController.dispose();
    super.dispose();
  }

  // Methods
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _changeColor() {
    setState(() {
      _colorIndex = (_colorIndex + 1) % _colors.length;
      _boxColor = _colors[_colorIndex];
    });
  }

  void _updateName() {
    setState(() {
      _displayName = _nameController.text;
      _nameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management Examples'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Counter Example
            const Text(
              'Counter Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Count: $_counter',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Color Changer Example
            const Text(
              'Color Changer Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: 150,
              height: 150,
              color: _boxColor,
              child: const Center(
                child: Text(
                  'Tap the button below',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _changeColor,
              child: const Text('Change Color'),
            ),

            const SizedBox(height: 40),

            // Form Example
            const Text(
              'Name Form Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter Your Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _updateName,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 10),
            _displayName.isEmpty
                ? const Text('Enter your name above')
                : Text(
                    'Hello, $_displayName!',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
