import 'dart:convert';
import 'package:http/http.dart' as http;

class AddUsersRepository {
  Future<int> addMember(user) async {
    final url =
        'https://us-central1-haraka-livraison.cloudfunctions.net/createUser';
    dynamic body = jsonEncode(user);

    try {
      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        return 1;
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (_) {
      print(_);
      return null;
    }
  }
}
