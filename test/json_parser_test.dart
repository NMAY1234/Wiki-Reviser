import 'package:test/test.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  test('test data opened', () async {
    String jsonFile =
        await File('test/json_parser_test_file.json').readAsString();
    expect(jsonFile, startsWith('{"continue":{"rvcontinue"'));
  });

  test('Read a user revision by the name', () async {
    final jsonFile =
        await File('test/json_parser_test_file.json').readAsString();

    final mapData = jsonDecode(jsonFile);

    final page1 = mapData["query"]["pages"].entries.first.value;
    final answer = page1["revisions"][0]["user"];
    expect(answer, 'Tom.Reding');
  });
}
