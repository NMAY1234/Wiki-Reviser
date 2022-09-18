import 'dart:convert';
import 'dart:io';

class RevisionParser {
  Future<List> jsonParseOutUsername(File fileFromRequest) async {
    final jsonFileFromRequest = await fileFromRequest.readAsString();
    final jsonDataAsMap = jsonDecode(jsonFileFromRequest);

    final revisionHistory =
        jsonDataAsMap["query"]["pages"].entries.first.value["revisions"];

    var num = 0;
    var nameList = [];
    for (var i = num; i <= 5; i++) {
      nameList.add(revisionHistory[i]["user"]);
    }
    return nameList;
  }
}
