import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twd_nmmay_jamisontucker/wikipedia_url_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wikipedia Revision History',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const Scaffold(
          body: WikipediaRevisionHistoryHomePage(),
        ));
  }
}

class WikipediaRevisionHistoryHomePage extends StatefulWidget {
  const WikipediaRevisionHistoryHomePage({Key? key}) : super(key: key);

  @override
  State<WikipediaRevisionHistoryHomePage> createState() =>
      _WikipediaRevisionHistoryHomePage();
}

class _WikipediaRevisionHistoryHomePage
    extends State<WikipediaRevisionHistoryHomePage> {
  String _message = 'Type in a the key word for a wikipedia article';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            child: TextField(controller: _controller),
            width: 200,
          ),
          ElevatedButton(
            onPressed: _onButtonPressed,
            child: Text("Search"),
          ),
        ],
      ),
    );
  }

  void _onButtonPressed() async {
    String input = _controller.value.text;
    var urlToSendRequest =
        Uri.parse(WikipediaURLBuilder().searchTermToUrl(input));
    var response = await http.post(urlToSendRequest, headers: {
      'user-agent':
          'Revision Reporter/0.1 (http://www.cs.bsu.edu/~pvg/courses/cs222Fa22; nmmay@bsu.edu)'
    });

    setState(() {
      // _message = result;
    });
  }
}
