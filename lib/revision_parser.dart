import 'dart:convert';
import 'dart:io';

class RevisionParser {
  Future<String> jsonParseOutUsername(File fileFromRequest) async {
    final jsonFileFromRequest = await fileFromRequest.readAsString();
    final jsonDataAsMap = jsonDecode(jsonFileFromRequest);
    final revisionHistory = jsonDataAsMap["query"]["pages"]
        .entries
        .first
        .value["revisions"][0]["user"];
    return revisionHistory;
  }
}
