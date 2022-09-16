class WikipediaURLBuilder {
  String searchTermToURL(String term) {
    var urlString =
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions&titles=$term&rvprop=timestamp%7Cuser&rvlimit=30';
    return urlString;
  }
}
