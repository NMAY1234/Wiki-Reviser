class WikipediaURLBuilder {
  String searchTermToUrl(String term) {
    var urlString =
        'http://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions%7Credirects&list=&exportschema=0.10&titles=$term&redirects=1&rvprop=timestamp%7Cuser&rvlimit=30&rdprop=title';
    return urlString;
  }
}
