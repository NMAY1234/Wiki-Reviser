import 'package:flutter/material.dart';
import 'package:twd_nmmay_jamisontucker/network_reader.dart';
import 'package:twd_nmmay_jamisontucker/wikipedia_url_builder.dart';
import 'package:twd_nmmay_jamisontucker/revision_parser.dart';
import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
            toolbarHeight: 20,
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
            width: 250,
            height: 25,
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

    String wikiStatusMessage;
    var userInternetStatus = await InternetConnectionChecker().hasConnection;
    if (userInternetStatus == false) {
      wikiStatusMessage = 'No Internet Connection';
      setState(() {
        _message = wikiStatusMessage;
        _isProcessing = false;
      });
    }

    final userSearchTermAsUri = Uri.parse(
        WikipediaURLBuilder().searchTermToUrl(_controller.value.text));
    final receivedWikipediaResponse =
        await NetworkReader().readResponse(userSearchTermAsUri);

    final wikipediaJsonFile = receivedWikipediaResponse.body.toString();
    if (wikipediaJsonFile.startsWith('{"batchcomplete":')) {
      setState(() {
        _message = 'No such page exists for ${_controller.value.text}';
        _isProcessing = false;
      });
    }

    final wikipediaDataMap = jsonDecode(wikipediaJsonFile);
    final wikipediaRevisionData = await RevisionParser()
        .jsonParseOutUsernameAndTimestamp(wikipediaDataMap);
    final wikipediaRedirectData =
        RevisionParser().hasRedirects(wikipediaDataMap);
    final pageName = RevisionParser().showsExactPageName(wikipediaDataMap);
    final networkResponseStatus = receivedWikipediaResponse.statusCode;

    if (networkResponseStatus == 200) {
      wikiStatusMessage = 'Connection made! Code: 200';
    } else {
      wikiStatusMessage = """
      Your network request took too long to process.
      Please try again. Error Code: $networkResponseStatus
      """;
      setState(() {
        _message = wikiStatusMessage;
        _isProcessing = false;
      });
    }

    setState(() {
      _revisions = wikipediaRevisionData;
      _message =
          '$wikiStatusMessage $wikipediaRedirectData\n Your Page Name: $pageName';
      _isProcessing = false;
    });
  }
}
