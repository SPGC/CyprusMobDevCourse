import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: Center(child: MyHomePage())),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  constraints: const BoxConstraints(
                      minHeight: 75, minWidth: 75, maxHeight: 75, maxWidth: 75),
                  color: Colors.blueGrey,
                  child: const Icon(Icons.arrow_upward)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      constraints: const BoxConstraints(
                          minHeight: 75,
                          minWidth: 75,
                          maxHeight: 75,
                          maxWidth: 75),
                      color: Colors.blueGrey,
                      child: const Icon(Icons.arrow_back)),
                  Container(
                    constraints: const BoxConstraints(
                        minHeight: 75,
                        minWidth: 10,
                        maxHeight: 75,
                        maxWidth: 10),
                    color: Colors.white,
                  ),
                  Container(
                      constraints: const BoxConstraints(
                          minHeight: 75,
                          minWidth: 75,
                          maxHeight: 75,
                          maxWidth: 75),
                      color: Colors.blueGrey,
                      child: const Icon(Icons.arrow_forward)),
                ],
              ),
              Container(
                constraints: const BoxConstraints(
                    minHeight: 75, minWidth: 75, maxHeight: 75, maxWidth: 75),
                color: Colors.blueGrey,
                child: const Icon(Icons.arrow_downward),
              ),
            ],
          ),
        ),
        Center(
            child: Container(
          constraints: const BoxConstraints(maxHeight: 500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                fillColor: Colors.indigo,
                constraints: const BoxConstraints(minWidth: 75, minHeight: 75),
                child: const Text("X", style: TextStyle(color: Colors.white)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    fillColor: Colors.yellow,
                    constraints:
                        const BoxConstraints(minWidth: 75, minHeight: 75),
                    child:
                        const Text("Y", style: TextStyle(color: Colors.white)),
                  ),
                  RawMaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    fillColor: Colors.green,
                    constraints:
                        const BoxConstraints(minWidth: 75, minHeight: 75),
                    child:
                        const Text("A", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              RawMaterialButton(
                onPressed: () {},
                constraints: const BoxConstraints(minWidth: 75, minHeight: 75),
                shape: const CircleBorder(),
                fillColor: Colors.red,
                child: const Text("B", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
