import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:math/assets/link_api.dart';

class Connection {
  static Connection? _connectionInstance;

  Connection._();
  static Connection getInstance() {
    _connectionInstance ??= Connection._();
    return _connectionInstance!;
  }

  getRequest({String? url}) async {
    try {
      var response = await http.get(Uri.parse(url!));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Connection Error ${response.statusCode}");
      }
    } catch (e) {
      print("Connection Error $e");
    }
  }

  postRequest(
      {required String url, required String data}) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $kAPIKey",
        },
        body: json.encode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "system", "content": "assist"},
              {"role": "user", "content": data}
            ]
          },
        ),
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Connection Error ${response.statusCode}");
      }
    } catch (e) {
      print("Connection Error $e");
    }
  }
}
