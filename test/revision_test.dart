import 'package:flutter_test/flutter_test.dart';
import 'package:twd_nmmay_jamisontucker/revision_parser.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  test('this tests the map parameter', () async {
    String jsonFile =
        await File('test/json_parser_test_file.json').readAsString();
    final jsonDataAsMap = jsonDecode(jsonFile);
    var revisions =
        await RevisionParser().jsonParseOutUsernameAndTimestamp(jsonDataAsMap);

    var expectedNames = [
      'Tom.Reding',
      '2017-06-06T02:24:07Z',
      'Mwtoews',
      '2008-01-29T22:55:53Z',
      'Gurch',
      '2007-05-02T21:51:23Z',
      '166.113.0.70',
      '2007-05-02T19:58:50Z',
      'Fang Aili',
      '2007-04-16T16:10:30Z'
    ];
    expect(expectedNames, revisions);
  });

  test('this is a test to find the redirects', () async {
    String jsonFile =
        await File('test/json_revision_redirects_test.json').readAsString();
    final jsonDataAsMap = jsonDecode(jsonFile);
    var redirect = await RevisionParser().hasRedirects(jsonDataAsMap);
    expect(redirect, 'Joe Biden');
  });

  test('there are no redirects', () async {
    String jsonFile =
        await File('test/json_parser_test_file.json').readAsString();
    final jsonDataAsMap = jsonDecode(jsonFile);
    var redirect = await RevisionParser().hasRedirects(jsonDataAsMap);
    expect(redirect, 'No Redirects');
  });
}
