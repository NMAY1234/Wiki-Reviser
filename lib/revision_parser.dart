import 'dart:convert';
import 'dart:io';

class RevisionParser {
  Future<List> jsonParseOutUsernameAndTimestamp(Map fileFromRequest) async {
    //parameter will be changed for use with strings

    /*final jsonFileFromRequest = await fileFromRequest
        .readAsString(); //might be deleted for use with strings
    final jsonDataAsMap = jsonDecode(jsonFileFromRequest);*/
    final revisionHistory =
        fileFromRequest["query"]["pages"].entries.first.value["revisions"];
    final revisionHistoryLength = revisionHistory.length;

    var revisionList = [];
    var iterator = 0;
    for (var i = iterator; i < revisionHistoryLength; i++) {
      revisionList.add(revisionHistory[i]["user"]);
      revisionList.add(revisionHistory[i]["timestamp"]);
    }
    return revisionList;
  }

  hasDisconnectionsFromNetwork(Map fileFromRequest) {}

  hasRedirects(Map fileFromRequest) {
    final redirectKey = fileFromRequest["query"];
    if (redirectKey.containsKey(["redirects"][0])) {
      return redirectKey["redirects"][0]["to"];
    } else {
      return "No Redirects";
    }
  }
}
