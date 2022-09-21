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

    var revisionList = [];
    var iterator = 0;
    for (var i = iterator; i < 5; i++) {
      revisionList.add(revisionHistory[i]["user"]);
      revisionList.add(revisionHistory[i]["timestamp"]);
    }
    return revisionList;
  }

  hasDisconnectionsFromNetwork(Map fileFromRequest) {}

  hasRedirects(Map fileFromRequests) {}
}
