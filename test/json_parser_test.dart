import 'package:test/test.dart';
import 'package:twd_nmmay_jamisontucker/revision_parser.dart';
import 'dart:io';

void main() {
  test('test data opened', () async {
    String jsonFile =
        await File('test/json_parser_test_file.json').readAsString();
    expect(jsonFile, startsWith('{"continue":{"rvcontinue"'));
  });

  /*test('First revision user found using revision parser', () async {
    var result = await RevisionParser()
        .jsonParseOutUsername(File('test/json_parser_test_file.json'));
    expect(result, 'Tom.Reding');
  });

  test('Second revision user', () async {
    var result = await RevisionParser()
        .jsonParseOutUsername(File('test/json_parser_test_file.json'));
    expect(result, 'Mwtoews');
  });*/

  test('This is the list of revisions using revision_parser', () async {
    var expectedNames = [
      'Tom.Reding',
      'Mwtoews',
      'Gurch',
      '166.113.0.70',
      'Fang Aili'
    ];
    var result = await RevisionParser()
        .jsonParseOutUsername(File('test/json_parser_test_file.json'));
    expect(result, expectedNames);
  });
}
