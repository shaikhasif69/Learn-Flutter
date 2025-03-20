import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math' as math;

class SensorsAndAnimations extends StatelessWidget {
  final String widgetToShow;

  const SensorsAndAnimations({super.key, required this.widgetToShow});

  @override
  Widget build(BuildContext context) {
    switch (widgetToShow) {
      case "AccelerometerDemo":
        return const AccelerometerDemo();
      case "GyroscopeDemo":
        return const GyroscopeDemo();
      case "SimpleAnimations":
        return const SimpleAnimations();
      default:
        return const AccelerometerDemo();
    }
  }
}

class AccelerometerDemo extends StatefulWidget {
  const AccelerometerDemo({super.key});

  @override
  State<AccelerometerDemo> createState() => _AccelerometerDemoState();
}

class _AccelerometerDemoState extends State<AccelerometerDemo> {
  AccelerometerEvent _accelerometerEvent = AccelerometerEvent(
    0,
    0,
    0,
      DateTime.now(),
  );
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  Color _backgroundColor = Colors.white;
  double _ballPositionX = 0;
  double _ballPositionY = 0;
  final double _maxOffset = 100;

  @override
  void initState() {
    super.initState();
    _startListeningToSensor();
  }

  void _startListeningToSensor() {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerEvent = event;

        // Calculate ball position based on tilt
        _ballPositionX = -event.x * 10;
        _ballPositionY = event.y * 10;

        // Clamp values to prevent the ball from moving too far
        _ballPositionX = _ballPositionX.clamp(-_maxOffset, _maxOffset);
        _ballPositionY = _ballPositionY.clamp(-_maxOffset, _maxOffset);

        // Change background color based on sensor values
        double magnitude = math
            .sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
        _backgroundColor = Color.fromARGB(
          255,
          (255 * (event.x.abs() / 10)).clamp(0, 255).toInt(),
          (255 * (event.y.abs() / 10)).clamp(0, 255).toInt(),
          (255 * (event.z.abs() / 10)).clamp(0, 255).toInt(),
        );
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer Demo'),
        centerTitle: true,
      ),
      backgroundColor: _backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(_ballPositionX, _ballPositionY),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Accelerometer Values:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('X: ${_accelerometerEvent.x.toStringAsFixed(3)}'),
                    Text('Y: ${_accelerometerEvent.y.toStringAsFixed(3)}'),
                    Text('Z: ${_accelerometerEvent.z.toStringAsFixed(3)}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Tilt your device to move the ball and change the background color!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GyroscopeDemo extends StatefulWidget {
  const GyroscopeDemo({super.key});

  @override
  State<GyroscopeDemo> createState() => _GyroscopeDemoState();
}

class _GyroscopeDemoState extends State<GyroscopeDemo>
    with SingleTickerProviderStateMixin {
  GyroscopeEvent _gyroscopeEvent = GyroscopeEvent(
    0,
    0,
    0,
      DateTime.now(),
  );
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  late AnimationController _animationController;
  double _rotationX = 0;
  double _rotationY = 0;
  double _rotationZ = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _startListeningToSensor();
  }

  void _startListeningToSensor() {
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeEvent = event;

        // Integrate gyroscope data to get orientation
        _rotationX += event.x * 0.1;
        _rotationY += event.y * 0.1;
        _rotationZ += event.z * 0.1;
      });
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gyroscope Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value * 2 * math.pi + _rotationZ,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..rotateX(_rotationX)
                      ..rotateY(_rotationY),
                    alignment: Alignment.center,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(5, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.threed_rotation,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gyroscope Values:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('X: ${_gyroscopeEvent.x.toStringAsFixed(3)} rad/s'),
                    Text('Y: ${_gyroscopeEvent.y.toStringAsFixed(3)} rad/s'),
                    Text('Z: ${_gyroscopeEvent.z.toStringAsFixed(3)} rad/s'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Rotate your device to control the cube rotation!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _rotationX = 0;
                  _rotationY = 0;
                  _rotationZ = 0;
                });
              },
              child: const Text('Reset Rotation'),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleAnimations extends StatefulWidget {
  const SimpleAnimations({super.key});

  @override
  State<SimpleAnimations> createState() => _SimpleAnimationsState();
}

class _SimpleAnimationsState extends State<SimpleAnimations>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Examples'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Container'),
            Tab(text: 'Opacity'),
            Tab(text: 'Transform'),
            Tab(text: 'Hero'),
            Tab(text: 'Explicit'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AnimatedContainerExample(),
          AnimatedOpacityExample(),
          AnimatedTransformExample(),
          HeroAnimationExample(),
          ExplicitAnimationExample(),
        ],
      ),
    );
  }
}

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;
  BorderRadius _borderRadius = BorderRadius.circular(8);

  void _randomize() {
    final random = math.Random();
    setState(() {
      _width = random.nextInt(200).toDouble() + 50;
      _height = random.nextInt(200).toDouble() + 50;
      _color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      _borderRadius = BorderRadius.circular(random.nextInt(50).toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _randomize,
            child: const Text('Animate!'),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'AnimatedContainer automatically animates between old and new values of properties when they change.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedOpacityExample extends StatefulWidget {
  const AnimatedOpacityExample({super.key});

  @override
  State<AnimatedOpacityExample> createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  double _opacity = 1.0;

  void _toggleOpacity() {
    setState(() {
      _opacity = _opacity == 1.0 ? 0.0 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 1),
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Fade Me',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _toggleOpacity,
            child: Text(_opacity == 1.0 ? 'Fade Out' : 'Fade In'),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'AnimatedOpacity gradually changes the opacity of its child when the opacity property changes.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedTransformExample extends StatefulWidget {
  const AnimatedTransformExample({super.key});

  @override
  State<AnimatedTransformExample> createState() =>
      _AnimatedTransformExampleState();
}

class _AnimatedTransformExampleState extends State<AnimatedTransformExample> {
  double _angle = 0;
  double _scale = 1;

  void _rotate() {
    setState(() {
      _angle += math.pi / 4; // Rotate by 45 degrees
    });
  }

  void _changeSize() {
    setState(() {
      _scale = _scale == 1 ? 1.5 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            transform: Matrix4.identity()
              ..rotateZ(_angle)
              ..scale(_scale),
            transformAlignment: Alignment.center,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Transform Me',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _rotate,
                child: const Text('Rotate'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _changeSize,
                child: const Text('Scale'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'AnimatedContainer can also animate transformations like rotation and scaling.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class HeroAnimationExample extends StatelessWidget {
  const HeroAnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HeroDetailScreen(),
                ),
              );
            },
            child: Hero(
              tag: 'imageHero',
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.flutter_dash,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Tap the square to see Hero Animation',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Hero animations create the illusion that an element is traveling between screens when navigating.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class HeroDetailScreen extends StatelessWidget {
  const HeroDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'imageHero',
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.flutter_dash,
                  color: Colors.white,
                  size: 150,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Hero Animation Complete!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExplicitAnimationExample extends StatefulWidget {
  const ExplicitAnimationExample({super.key});

  @override
  State<ExplicitAnimationExample> createState() =>
      _ExplicitAnimationExampleState();
}

class _ExplicitAnimationExampleState extends State<ExplicitAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150 + 100 * _animation.value,
            height: 150 + 100 * _animation.value,
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              borderRadius: BorderRadius.circular(20 * _animation.value),
            ),
            child: Center(
              child: Text(
                'Value: ${_animation.value.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.forward();
                },
                child: const Text('Forward'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _controller.reverse();
                },
                child: const Text('Reverse'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _controller.repeat(reverse: true);
                },
                child: const Text('Loop'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _controller.stop();
                },
                child: const Text('Stop'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Explicit animations use AnimationController and provide precise control over the animation state.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
