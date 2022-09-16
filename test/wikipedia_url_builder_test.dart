import 'package:test/test.dart';
import 'package:twd_nmmay_jamisontucker/wikipedia_url_builder.dart';

void main() {
  test('This is the query url for "potato"', () {
    String searchTerm = WikipediaURLBuilder().searchTermToURL('potato');
    String expected =
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions&titles=potato&rvprop=timestamp%7Cuser&rvlimit=30';
    expect(searchTerm, expected);
  });
}
