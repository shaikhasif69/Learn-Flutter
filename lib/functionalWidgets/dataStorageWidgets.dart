import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DataStorage extends StatelessWidget {
  final String widgetToShow;

  const DataStorage({super.key, required this.widgetToShow});

  @override
  Widget build(BuildContext context) {
    switch (widgetToShow) {
      case "UserPreferences":
        return const UserPreferences();
      case "SimpleNotepad":
        return const SimpleNotepad();
      case "SimpleCounter":
        return const SimpleCounter();
      case "ThemeSwitch":
        return const ThemeSwitch();
      default:
        return const UserPreferences();
    }
  }
}

class UserPreferences extends StatefulWidget {
  const UserPreferences({super.key});

  @override
  State<UserPreferences> createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool _isDarkMode = false;
  bool _isNotificationsEnabled = true;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _nameController.text = prefs.getString('user_name') ?? '';
      _ageController.text = prefs.getInt('user_age')?.toString() ?? '';
      _isDarkMode = prefs.getBool('is_dark_mode') ?? false;
      _isNotificationsEnabled =
          prefs.getBool('is_notifications_enabled') ?? true;
      _isDataLoaded = true;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_name', _nameController.text);
    await prefs.setInt('user_age', int.tryParse(_ageController.text) ?? 0);
    await prefs.setBool('is_dark_mode', _isDarkMode);
    await prefs.setBool('is_notifications_enabled', _isNotificationsEnabled);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferences saved successfully')),
    );
  }

  Future<void> _clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('user_name');
    await prefs.remove('user_age');
    await prefs.remove('is_dark_mode');
    await prefs.remove('is_notifications_enabled');

    setState(() {
      _nameController.text = '';
      _ageController.text = '';
      _isDarkMode = false;
      _isNotificationsEnabled = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferences cleared')),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Preferences'),
        centerTitle: true,
      ),
      body: _isDataLoaded
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.cake),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Enable or disable dark mode'),
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Notifications'),
                    subtitle: const Text('Enable or disable notifications'),
                    value: _isNotificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _isNotificationsEnabled = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _savePreferences,
                        icon: const Icon(Icons.save),
                        label: const Text('Save Preferences'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _clearPreferences,
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear Preferences'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class SimpleNotepad extends StatefulWidget {
  const SimpleNotepad({super.key});

  @override
  State<SimpleNotepad> createState() => _SimpleNotepadState();
}

class _SimpleNotepadState extends State<SimpleNotepad> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<Map<String, String>> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString('notes');

    if (notesJson != null) {
      final List<dynamic> decodedData = jsonDecode(notesJson);
      _notes = decodedData.map<Map<String, String>>((item) {
        return {
          'title': item['title'] as String,
          'content': item['content'] as String,
        };
      }).toList();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notes', jsonEncode(_notes));
  }

  void _addNote() {
    if (_titleController.text.isNotEmpty ||
        _contentController.text.isNotEmpty) {
      setState(() {
        _notes.add({
          'title': _titleController.text,
          'content': _contentController.text,
        });
        _titleController.clear();
        _contentController.clear();
      });
      _saveNotes();
    }
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
    _saveNotes();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Notepad'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _contentController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Content',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _addNote,
                        icon: const Icon(Icons.note_add),
                        label: const Text('Add Note'),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: _notes.isEmpty
                      ? const Center(child: Text('No notes yet. Add one!'))
                      : ListView.builder(
                          itemCount: _notes.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key('note_$index'),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                _deleteNote(index);
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                child: ListTile(
                                  title: Text(
                                    _notes[index]['title'] ?? 'Untitled',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle:
                                      Text(_notes[index]['content'] ?? ''),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _deleteNote(index),
                                  ),
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

class SimpleCounter extends StatefulWidget {
  const SimpleCounter({super.key});

  @override
  State<SimpleCounter> createState() => _SimpleCounterState();
}

class _SimpleCounterState extends State<SimpleCounter> {
  int _counter = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
      _isLoading = false;
    });
  }

  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
    });
    await prefs.setInt('counter', _counter);
  }

  Future<void> _decrementCounter() async {
    if (_counter > 0) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _counter--;
      });
      await prefs.setInt('counter', _counter);
    }
  }

  Future<void> _resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = 0;
    });
    await prefs.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Counter'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Persistent Counter:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$_counter',
                    style: const TextStyle(
                        fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _decrementCounter,
                        icon: const Icon(Icons.remove),
                        label: const Text('Decrease'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: _incrementCounter,
                        icon: const Icon(Icons.add),
                        label: const Text('Increase'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _resetCounter,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Counter'),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'This counter will persist even when you close the app!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
    );
  }
}

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool _isDarkMode = false;
  ThemeMode _currentTheme = ThemeMode.light;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('is_dark_mode') ?? false;
      _currentTheme = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
      _isLoading = false;
    });
  }

  Future<void> _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      _currentTheme = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
    await prefs.setBool('is_dark_mode', _isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _currentTheme,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Theme Switcher'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      size: 100,
                      color: _isDarkMode ? Colors.amber : Colors.orange,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Current Theme: ${_isDarkMode ? 'Dark Mode' : 'Light Mode'}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 30),
                    Switch(
                      value: _isDarkMode,
                      onChanged: (value) {
                        _toggleTheme();
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _toggleTheme,
                      icon: Icon(
                          _isDarkMode ? Icons.light_mode : Icons.dark_mode),
                      label: Text(
                          'Switch to ${_isDarkMode ? 'Light' : 'Dark'} Mode'),
                    ),
                    const SizedBox(height: 50),
                    Card(
                      margin: const EdgeInsets.all(20),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text(
                              'Theme Example',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const TextField(
                              decoration: InputDecoration(
                                labelText: 'Sample Input',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Sample Button'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
