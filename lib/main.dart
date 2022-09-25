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
  String _message = 'Type in a the key word for a wikipedia article';
  final _controller = TextEditingController();
  bool _isProcessing = false;
  List<dynamic> _revisions = [];

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: _revisions
                    .map((revision) => Text(revision.username))
                    .toList(),
              ),
              Column(
                children: _revisions
                    .map((revision) => Text(revision.timestamp))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onButtonPressed() async {
    setState(() {
      _isProcessing = true;
    });
    if (_controller.value.text == '') {
      setState(() {
        _isProcessing = false;
      });
    }
    final urlToSendRequest = Uri.parse(
        WikipediaURLBuilder().searchTermToUrl(_controller.value.text));

    final responseData = await NetworkReader().readResponse(urlToSendRequest);
    final jsonFileFromResponse = responseData.body.toString();
    final jsonFileAsDataMap = jsonDecode(jsonFileFromResponse);

    final revisionsFromResponse = await RevisionParser()
        .jsonParseOutUsernameAndTimestamp(jsonFileAsDataMap);
    final redirectFromResponse =
        RevisionParser().hasRedirects(jsonFileAsDataMap);

    var networkStatusFromResponse = responseData.statusCode;
    final String wikiStatusMessage;

    if (networkStatusFromResponse != 200) {
      wikiStatusMessage = """
      Your network request took too long to process.
      Please try again.
      """;
      setState(() {
        _message = wikiStatusMessage;
        _isProcessing = false;
      });
    } else {
      wikiStatusMessage = "Good connection made!";
    }

    setState(() {
      _revisions = revisionsFromResponse;
      _message = '$wikiStatusMessage $redirectFromResponse';
      _isProcessing = false;
    });
  }
}
