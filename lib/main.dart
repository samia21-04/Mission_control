import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  // set counter value
  int _counter = 0;

  // ✅ this controls what shows on screen
  String get _displayText => (_counter == 100) ? "LIFTOFF!" : '$_counter';

  void _incrementCounter() {
    setState(() {
      // Prevent going above 100
      if (_counter < 100) _counter++;
    });
  }

  Color _visualCountdownStatus(int counter) {
    if (counter == 0) {
      return Colors.red;
    } else if (counter > 0 && counter <= 50) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  void _launchRocket() {
    setState(() {
      if (_counter == 100) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Counter must reach 100 to launch the rocket.")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _visualCountdownStatus(_counter);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Launch Controller'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(12),
              child: Text(
                // Shows number OR LIFTOFF!
                _displayText,
                style: const TextStyle(fontSize: 50.0, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text('Ignite'),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: _launchRocket,
            child: const Text('Launch'),
          ),

          const SizedBox(height: 20),

          ColorFiltered(
            colorFilter: ColorFilter.mode(statusColor, BlendMode.srcIn),
            child: const Icon(Icons.rocket_launch, size: 80),
          ),

          const SizedBox(height: 20),

          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt().clamp(0, 100);
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
        ],
      ),
    );
  }
}