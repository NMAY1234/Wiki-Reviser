import 'package:flutter/material.dart';
import 'package:twd_nmmay_jamisontucker/network_reader.dart';
import 'package:twd_nmmay_jamisontucker/wikipedia_url_builder.dart';
import 'package:twd_nmmay_jamisontucker/revision_parser.dart';
import 'dart:convert';

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
  State<StatefulWidget> createState() => _WikipediaRevisionHistoryHomePage();
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
            width: 200,
            child: TextField(controller: _controller),
          ),
          ElevatedButton(
              onPressed: _onButtonPressed, child: const Text("Search")),
          Text(_message),
        ],
      ),
    );
  }

  void _onButtonPressed() async {
    final urlToSendRequest = Uri.parse(
        WikipediaURLBuilder().searchTermToUrl(_controller.value.text));

    final responseData = await NetworkReader().readResponse(urlToSendRequest);
    final jsonFileFromResponse = responseData.toString();
    final jsonFileAsDataMap = jsonDecode(jsonFileFromResponse);

    final revisionsFromResponse =
        RevisionParser().jsonParseOutUsernameAndTimestamp(jsonFileAsDataMap);
    //final networkStatusFromResponse = responseData.statusCode;
    final redirectFromResponse =
        RevisionParser().hasRedirects(jsonFileAsDataMap);

    setState(() {
      _message = revisionsFromResponse.toString();
    });
  }
}

class Revision extends StatelessWidget {
  const Revision({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
