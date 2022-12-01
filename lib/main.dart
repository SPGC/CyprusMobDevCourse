// imports packages (i.e. libraries) similar to Java
import 'package:cyprus_mobdev_course/main_page_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(const HelloWorldApp());

class HelloWorldApp extends StatelessWidget {
  const HelloWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(body: Center(child: TaskList() /*TaskList()*/)));
  }
}