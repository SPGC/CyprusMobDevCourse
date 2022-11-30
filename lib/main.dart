// imports packages (i.e. libraries) similar to Java
import 'package:flutter/material.dart';

void main() => runApp(const HelloWorldApp());

const title = 'Hello World';

class HelloWorldApp extends StatelessWidget {

  const HelloWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(title: const Text(title)),
            body: Center(
                child: MyCounterWidget()
            )
        )
    );
  }
}

class MyCounterWidget extends StatefulWidget {
  const MyCounterWidget({Key? key}) : super(key: key);

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounterWidget> {
  int _counter = 0;
  void _increase() {
    setState(() {
      _counter++;
    });
    debugPrint('counter: $_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$_counter', style: TextStyle(fontSize: 32)),
        const SizedBox(height: 20), // spacing of 20px height
        ElevatedButton(
            child: const Icon(Icons.plus_one),
            onPressed: () => _increase() // called when the button is pressed :-)
        ),
      ],
    );
  }
}