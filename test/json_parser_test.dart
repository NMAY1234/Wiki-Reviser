import 'package:test/test.dart';
import 'package:twd_nmmay_jamisontucker/revision_parser.dart';
import 'dart:io';

void main() {
  test('test data opened', () async {
    String jsonFile =
        await File('test/json_parser_test_file.json').readAsString();
    expect(jsonFile, startsWith('{"continue":{"rvcontinue"'));
  });

  test('List of user names of revisions using revision_parser', () async {
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
    var result = await RevisionParser().jsonParseOutUsernameAndTimestamp(
        File('test/json_parser_test_file.json'));
    expect(result, expectedNames);
  });

  test('This is the list of timestamps of revisions using revision_parser',
      () async {
    var expectedTimestamps = [
      '2017-06-06T02:24:07Z',
      '2008-01-29T22:55:53Z',
      '2007-05-02T21:51:23Z',
      '2007-05-02T19:58:50Z',
      '2007-04-16T16:10:30Z'
    ];
    var result = await RevisionParser().jsonParseOutUsernameAndTimestamp(
        File('test/json_parser_test_file.json'));
    expect(result, expectedTimestamps);
  });
}
