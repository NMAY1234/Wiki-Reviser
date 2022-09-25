import 'package:test/test.dart';
import 'package:twd_nmmay_jamisontucker/revision_parser.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  test('test data opened', () async {
    String jsonFile =
        await File('test/json_parser_test_file.json').readAsString();
    expect(jsonFile, startsWith('{"continue":{"rvcontinue"'));
  });

  test('User name and timestamp of revision using revision_parser', () async {
    var expectedNameAndTimeStamp = 'Tom.Reding 2017-06-06T02:24:07Z';
    String jsonFile =
        await File('test/json_parser_test_file.json').readAsString();
    final jsonDataAsMap = jsonDecode(jsonFile);
    var result =
        await RevisionParser().jsonParseOutUsernameAndTimestamp(jsonDataAsMap);
    var resultUsername = result[0].username;
    var resultTime = result[0].timestamp;
    String expectedResult = resultUsername + ' ' + resultTime;

    expect(expectedResult, expectedNameAndTimeStamp);
  });

  test('the time?', () {
    var time = '2007-04-16T16:10:30Z';
    var newTime = DateTime.parse(time).toString().substring(0, time.length - 1);
    expect(newTime, '2007-04-16 16:10:30');
  });
}
