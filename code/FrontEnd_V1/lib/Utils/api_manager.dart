import 'package:http/http.dart' as http;

class HttpService {
  final String baseURL = "http://127.0.0.1:5000";

  // Future<List<Products>> getPosts() async {
  //   Response res = await get(Uri.parse(postsURL));

  //   if (res.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(res.body);

  //     List<Products> posts = body
  //         .map(
  //           (dynamic item) => Products.fromJson(item),
  //         )
  //         .toList();
  //     return posts;
  //   } else {
  //     throw "Unable to retrieve posts.";
  //   }
  // }

  Future<dynamic> register(String databody) async {
    try {
      print(Uri.parse('$baseURL/register'));
      final http.Response response = await http.patch(
        Uri.parse("$baseURL/register"),
        body: {
          "username": "test",
          "email": "test@gmail.com",
          "password": "test123",
          "dob": "12-12-12"
        },
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}
