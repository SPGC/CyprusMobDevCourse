import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const HelloWorldApp());

const title = 'Ilia\'s startup name generator';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final myName = "Ilia";

  String _insertMyName(WordPair pair) {
    return "${pair.first}-$myName-${pair.second}";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return ListTile(
          title: Text(
            _insertMyName(_suggestions[index]),
            style: _biggerFont,
            textAlign: TextAlign.center,
          ),
          onTap: () async {
            final fakeUrl = Uri.parse("https://www.google.com/search?q=${_insertMyName(_suggestions[index])}");
            if (!await launchUrl(fakeUrl)) {
              throw 'Could not launch $fakeUrl';
            }
          },
        );
      },
    );
  }
}

class HelloWorldApp extends StatelessWidget {
  const HelloWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(title: const Text(title)),
            body: Center(child: RandomWords())));
  }
}
