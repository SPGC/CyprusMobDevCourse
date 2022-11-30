// imports packages (i.e. libraries) similar to Java
import 'package:flutter/material.dart';

// main function, used to launch app - note the lambda call
void main() => runApp(const HelloWorldApp());

// define the title as a global const so it can be used everywhere
const title = 'Hello World';

// this is the app - we will learn about widgets later
class HelloWorldApp extends StatelessWidget {
  // this is the constructor - we will learn about the 'key' later
  const HelloWorldApp({super.key});

  // this is the function that builds the UI - overridden from StatelessWidget
  @override
  Widget build(BuildContext context) {
    // the Material app uses the Material design to form a frame: m2.material.io/design
    return MaterialApp(
        // title (left side) is a 'named' parameter, and the title (right)
        // is the constant value defined earlier
        title: title,
        // defines the appbar (on top) and also allows for floating buttons, toasts/snacks, etc.
        home: Scaffold(
            // simple appbar with a title
            appBar: AppBar(title: const Text(title)),
            // the body consists of a simple text UI element
            body: const Center(
                child: Text(
              'Hello, Ilia!',
              style: TextStyle(color: Colors.red, fontSize: 30),
            ))));
  }
}
