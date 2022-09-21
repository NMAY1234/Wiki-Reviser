import 'package:test/test.dart';
import 'package:twd_nmmay_jamisontucker/wikipedia_url_builder.dart';

void main() {
  test('This is the query url for "potato"', () {
    String searchTerm = WikipediaURLBuilder().searchTermToUrl('potato');
    String expected =
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions%7Credirects&list=&exportschema=0.10&titles=potato&redirects=1&rvprop=timestamp%7Cuser&rvlimit=30&rdprop=title';
    expect(searchTerm, expected);
  });
}
