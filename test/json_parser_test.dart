import 'package:test/test.dart';
import 'package:twd_nmmay_jamisontucker/revision_parser.dart';
import 'dart:io';

void main() {
  test('test data opened', () async {
    String jsonFile =
        await File('test/json_parser_test_file.json').readAsString();
    expect(jsonFile, startsWith('{"continue":{"rvcontinue"'));
  });

  test('First revision user found using revision parser', () async {
    var result = await RevisionParser()
        .jsonParseOutUsername(File('test/json_parser_test_file.json'));
    expect(result, 'Tom.Reding');
  });

  /*test('Read a user revision by the name', () async {
    final jsonFile =
        await File('test/json_parser_test_file.json').readAsString();

    final mapData = jsonDecode(jsonFile);

    final page1 = mapData["query"]["pages"].entries.first.value;
    final revisionUserName = page1["revisions"][0]["user"];
    final revisionTimeStamp = page1["revisions"][0]["timestamp"];

    expect(revisionUserName, 'Tom.Reding');
    expect(revisionTimeStamp, '2017-06-06T02:24:07Z');
  });*/
}
