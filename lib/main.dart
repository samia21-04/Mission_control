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
  
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Color _visualCountdownStatus(int counter){
    if (counter == 0){
      return Colors.red;
    } else if (counter > 0 && counter <= 50){
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text(
                '$_counter',
                style: const TextStyle(fontSize: 50.0),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text('Ignite'),
             ), //Elevated Button (Ignite)
             const SizedBox(height: 20),

            ColorFiltered(
              colorFilter: ColorFilter.mode(_visualCountdownStatus(_counter), 
              BlendMode.srcIn),
             ), //ColorFiltered
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
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