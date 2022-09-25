class RevisionParser {
  Future<List> jsonParseOutUsernameAndTimestamp(Map fileFromRequest) async {
    final revisionHistory =
        fileFromRequest["query"]["pages"].entries.first.value["revisions"];

    final revisionHistoryLength = revisionHistory.length;

    var revisionList = [];
    var iterator = 0;
    for (var i = iterator; i < revisionHistoryLength; i++) {
      revisionList.add(UserRevisionData(
        revisionHistory[i]["user"],
        formatIso8601toUTC(revisionHistory[i]["timestamp"]),
      ));
    }
    return revisionList;
  }

  formatIso8601toUTC(var time) {
    var utcTime = DateTime.parse(time).toString().substring(0, time.length - 1);
    return utcTime;
  }

  hasRedirects(Map fileFromRequest) {
    final redirectKey = fileFromRequest["query"];
    if (redirectKey.containsKey(["redirects"][0])) {
      String rKey = redirectKey["redirects"][0]["to"];
      return 'Redirected to $rKey';
    } else {
      return "No Redirects";
    }
  }
}

class UserRevisionData {
  final String username;
  final String timestamp;

  UserRevisionData(this.username, this.timestamp);
}
