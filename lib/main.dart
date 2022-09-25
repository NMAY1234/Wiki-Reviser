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
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Revision Finder",
            ),
          ),
          body: const WikipediaRevisionHistoryHomePage(),
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
  final _message = 'Type in a the key word for a wikipedia article';
  final _controller = TextEditingController();
  bool _isProcessing = false;
  List<dynamic> _revisions = [];
  String _responseStatus = "";
  String _redirects = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: TextField(controller: _controller),
          ),
          ElevatedButton(
              onPressed: _isProcessing ? null : _onButtonPressed,
              child: const Text("Search")),
          Text(_message),
          Column(
            children:
                _revisions.map((revision) => Text(revision.username)).toList(),
          ),
        ],
      ),
    );
  }

  void _onButtonPressed() async {
    _isProcessing = true;
    final urlToSendRequest = Uri.parse(
        WikipediaURLBuilder().searchTermToUrl(_controller.value.text));

    final responseData = await NetworkReader().readResponse(urlToSendRequest);
    final jsonFileFromResponse = responseData.body.toString();
    final jsonFileAsDataMap = jsonDecode(jsonFileFromResponse);

    final revisionsFromResponse = await RevisionParser()
        .jsonParseOutUsernameAndTimestamp(jsonFileAsDataMap);
    final networkStatusFromResponse = responseData.statusCode;
    final redirectFromResponse =
        RevisionParser().hasRedirects(jsonFileAsDataMap);

    setState(() {
      _revisions = revisionsFromResponse;
      _responseStatus = networkStatusFromResponse.toString();
      _redirects = redirectFromResponse;
      _isProcessing = false;
    });
  }
}
