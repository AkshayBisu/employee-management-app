import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_task/constant/constant.dart';

Future postReq(String url, [String token = '', Map payload = const {}]) async {
  final fullUrl = baseUrl + url;

  try {
    final res = await http.post(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,
        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(payload),
    );

    print(" STATUS: ${res.statusCode}");
    print("  RESPONSE: ${res.body}");

    final data = jsonDecode(res.body);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return {"success": true, "data": data};
    } else {
      return {
        "success": false,
        "message": data["error"] ?? "Something went wrong",
      };
    }
  } catch (e) {
    print("  ERROR: $e");
    return {"success": false, "message": e.toString()};
  }
}

Future getReq(String url, [String token = ""]) async {
  final fullUrl = baseUrl + url;

  final res = await http.get(
    Uri.parse(fullUrl),
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': apiKey,

      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    },
  );

  return res;
}

Future putReq(String url, [String token = '', Map payload = const {}]) async {
  final fullUrl = baseUrl + url;

  try {
    final res = await http.put(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,

        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(payload),
    );

    final data = jsonDecode(res.body);

    return {
      "success": res.statusCode >= 200 && res.statusCode < 300,
      "data": data,
    };
  } catch (e) {
    return {"success": false, "message": e.toString()};
  }
}

Future patchReq(String url, [String token = '', Map payload = const {}]) async {
  final fullUrl = baseUrl + url;

  try {
    final res = await http.patch(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,

        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(payload),
    );

    final data = jsonDecode(res.body);

    return {
      "success": res.statusCode >= 200 && res.statusCode < 300,
      "data": data,
    };
  } catch (e) {
    return {"success": false, "message": e.toString()};
  }
}

Future deleteReq(String url, [String token = ""]) async {
  final fullUrl = baseUrl + url;

  try {
    final res = await http.delete(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,

        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
    );

    return {
      "success": res.statusCode >= 200 && res.statusCode < 300,
      "message": "Deleted successfully",
    };
  } catch (e) {
    return {"success": false, "message": e.toString()};
  }
}
