import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'data/ModelSearch/SearchModels.dart';

class NetworkHandler {
  String baseurl = "http://192.168.0.2:7000";
  String baseurlpython = "http://10.0.2.2:5000"; //10.0.2.2

  var log = Logger();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future get(String url) async {
    String? token = await storage.read(key: "token");
    url = formater(url);

    var response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future checkuser(String url, String token) async {
    //String? token = await storage.read(key: "token");
    url = formater(url);

    var response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future get1(String url) async {
    url = formater(url);

    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    String? token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> patch(String url, Map<String, String> body) async {
    String? token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> patch1(String url, Map<String, dynamic> body) async {
    String? token = await storage.read(key: "token");

    url = formater(url);
    log.d(body);
    print(url);
    var response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    print(body);
    return response;
  }

  Future<http.Response> patch2(String url, Map<String, dynamic> body) async {
    String? token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> post1(String url, var body) async {
    url = formater(url);
    log.d(body);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    url = formater(url);
    String? token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    String url = formater("/uploads//$imageName.jpg");

    return NetworkImage(url);
  }

  Future<String> getImagestatus(String imageName) async {
    String url = formater("/uploads//$imageName.jpg");

    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 404) {
      return "false";
    } else {
      return "true";
    }
  }

  getImageurl(String imageName) {
    String url = formater("/uploads//$imageName.jpg");

    return url;
  }

  Future<http.Response> delete(String url) async {
    url = formater(url);
    print(url);
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
      },
    );

    return response;
  }

  String formater_py(String url) {
    return baseurlpython + url;
  }

  Future get_py(String url) async {
    url = formater_py(url);

    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body) as Map<String, dynamic>;
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post_py(String url, var body) async {
    url = formater_py(url);
    log.d(body);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }
}