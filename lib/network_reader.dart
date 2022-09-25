import 'package:http/http.dart' as http;

class NetworkReader {
  Future<http.Response> readResponse(Uri uri) async {
    final response = await http.get(uri, headers: {
      'user-agent':
          'Revision Reporter/0.1 (http://www.cs.bsu.edu/~pvg/courses/cs222Fa22; nmmay@bsu.edu)'
    });
    return response;
  }
}
