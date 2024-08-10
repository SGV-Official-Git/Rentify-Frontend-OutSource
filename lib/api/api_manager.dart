import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utilities/helper_func.dart';
import '../utilities/keys.dart';
import '../utilities/sp.dart';
import '../widgets/error_dialog.dart';
import 'api_response.dart';

class ApiManager {
  static final instance = ApiManager();

  final Map<String, String> _headers = {"Content-Type": "application/json"};

  String host = '', scheme = '', path = '';
  int port = 0;

  void init(String baseUrl) {
    scheme = HelperMethods.instance.getUri(baseUrl).scheme;
    host = HelperMethods.instance.getUri(baseUrl).host;
    path = HelperMethods.instance.getUri(baseUrl).path;
    port = HelperMethods.instance.getUri(baseUrl).port;
    printMetaData(baseUrl: baseUrl, headers: _headers);
  }

  Future<bool> checkInternet() async {
    try {
      final response = await http.get(Uri.parse("https://www.google.com"));
      if (response.statusCode >= 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Uri buildUri(
      {required String endpoint, Map<String, dynamic>? queryParameters}) {
    return Uri(
        scheme: scheme,
        host: host,
        port: port,
        path: "$path$endpoint",
        queryParameters: queryParameters);
  }

  Future<ApiResponse?> get(
      {required String endpoint, Map<String, dynamic>? queryParameters}) async {
    final isInternet = await checkInternet();
    final uri = buildUri(
        endpoint: endpoint.toString(), queryParameters: queryParameters);
    if (isInternet) {
      try {
        final accessToken = SP.i.getString(key: SPKeys.accessToken);
        if (accessToken != null) {
          _headers['Authorization'] = 'Bearer $accessToken';
        }
        final response = await http.get(uri, headers: _headers);
        printMetaData(
            baseUrl: uri.toString(),
            headers: _headers,
            request: queryParameters,
            response: response.body);
        ApiResponse finalResponse = validateResponse(response);
        return finalResponse;
      } catch (e) {
        log("METHOD-> GET \n ERROR -> $e");
        rethrow;
      }
    } else {
      alert(
          type: AlertType.error,
          message: "Please check your internet connection");
      return null;
    }
  }

  Future<ApiResponse?> post(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      required Map<dynamic, dynamic> jsonBody}) async {
    final isInternet = await checkInternet();
    final uri = buildUri(endpoint: endpoint, queryParameters: queryParameters);
    if (isInternet) {
      try {
        final accessToken = SP.i.getString(key: SPKeys.accessToken);
        if (accessToken != null) {
          _headers['Authorization'] = 'Bearer $accessToken';
        }
        final response =
            await http.post(uri, headers: _headers, body: jsonEncode(jsonBody));

        printMetaData(
            baseUrl: uri.toString(),
            headers: _headers,
            request: jsonBody,
            response: response.body);

        ApiResponse finalResponse = validateResponse(response);
        return finalResponse;
      } catch (e) {
        printMetaData(
          baseUrl: uri.toString(),
          headers: _headers,
          request: jsonBody,
        );
        log("METHOD-> POST \n ERROR -> $e");
        rethrow;
      }
    } else {
      alert(
          type: AlertType.error,
          message: "Please check your internet connection");
      return null;
    }
  }

  Future<ApiResponse?> postWithImage<T>(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      required String key,
      required Map<dynamic, dynamic> jsonBody}) async {
    final isInternet = await checkInternet();
    final uri = buildUri(endpoint: endpoint, queryParameters: queryParameters);
    if (isInternet) {
      try {
        final accessToken = SP.i.getString(key: SPKeys.accessToken);
        if (accessToken != null) {
          _headers['Authorization'] = 'Bearer $accessToken';
        }
        final request = http.MultipartRequest('POST', uri);
        request.headers.addAll(_headers);
        jsonBody.forEach((reqKey, value) {
          if (reqKey != key) {
            request.fields[reqKey] = value;
          }
        });

        if (T == File && jsonBody[key] != null) {
          final image = File(jsonBody[key]);

          request.files.add(await http.MultipartFile.fromPath(key, image.path));
        }
        final responseStream = await request.send();
        final response = await responseStream.stream.bytesToString();

        printMetaData(
            baseUrl: uri.toString(),
            headers: _headers,
            request: jsonBody,
            response: response);
        return ApiResponse(getBody(response), getMessage(response),
            getStatusCode(response), getStatus(response));
      } catch (e) {
        printMetaData(
          baseUrl: uri.toString(),
          headers: _headers,
          request: jsonBody,
        );
        log("METHOD-> POST \n ERROR -> $e");
        rethrow;
      }
    } else {
      alert(
          type: AlertType.error,
          message: "Please check your internet connection");
      return null;
    }
  }

  ApiResponse validateResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiResponse(getBody(response.body), getMessage(response.body),
            getStatusCode(response.body), getStatus(response.body));
      default:
        return ApiResponse(getBody(response.body), getMessage(response.body),
            getStatusCode(response.body), getStatus(response.body));
    }
  }

  String getErrorMessage(Object e) {
    if (e is SocketException) {
      // Handle SocketException
      return 'Request timed out. Please try again later.';
    } else if (e is TimeoutException) {
      // Handle TimeoutException
      return 'Request timed out. Please try again later.';
    } else if (e is FormatException) {
      // Handle FormatException
      return 'Invalid data format. Please try again later.';
    } else if (e is IOException) {
      // Handle IOException
      return 'Input/output error occurred. Please try again later.';
    } else if (e is HttpException) {
      // Handle HttpException
      return 'HTTP error occurred. Please try again later.';
    } else if (e is ArgumentError) {
      // Handle ArgumentError
      return 'Invalid argument error occurred. Please contact support.';
    } else if (e is AssertionError) {
      // Handle AssertionError
      return 'Assertion error occurred. Please contact support.';
    } else if (e is UnimplementedError) {
      // Handle UnimplementedError
      return 'This feature is not implemented yet. Please stay tuned.';
    } else if (e is StateError) {
      // Handle StateError
      return 'State error occurred. Please try again later.';
    } else {
      // For other exceptions, print the stack trace
      return 'An unexpected error occurred. Please contact support.';
    }
  }

  bool getStatusCode(String body) {
    final jsonBody = jsonDecode(body);
    return jsonBody['success'];
  }

  int getStatus(String body) {
    final jsonBody = jsonDecode(body);

    if (jsonBody['statusCode'].runtimeType == String) {
      if (jsonBody['statusCode'] == '500') {
        SP.i.signOut();
      }
      return int.parse(jsonBody['statusCode']);
    }
    if (jsonBody['statusCode'] == 500) {
      SP.i.signOut();
    }
    return jsonBody['statusCode'];
  }

  String getMessage(String body) {
    final jsonBody = jsonDecode(body) as Map<String, dynamic>;
    if (jsonBody.containsKey("message")) {
      return jsonBody['message'];
    } else if (jsonBody.containsKey("errors")) {
      if (jsonBody["errors"].runtimeType == List) {
        return (jsonBody["errors"] as List).join(",");
      } else {
        return jsonBody["errors"];
      }
    } else {
      return "Something went wrong!";
    }
  }

  dynamic getBody(String body) {
    final jsonBody = jsonDecode(body);
    if (jsonBody['data'] != null) {
      return jsonBody['data'];
    } else {
      return null;
    }
  }

  String formatJson(dynamic body) {
    return const JsonEncoder.withIndent('  ').convert(body);
  }

  void printMetaData(
      {String? baseUrl, dynamic headers, dynamic request, dynamic response}) {
    if (kDebugMode) {
      final accessToken = SP.i.getString(key: SPKeys.accessToken);

      if (accessToken != null) {
        log('Access-Token ==> $accessToken');
      }
      if (baseUrl != null) {
        log("Base-Url ==> $baseUrl");
      }
      if (headers != null) {
        log("Headers ==> ${formatJson(headers)}");
      }
      if (request != null) {
        log("Request ==> ${formatJson(request)}");
      }
      if (response != null) {
        log("Response ==> ${formatJson(jsonDecode(response))}");
      }
    }
  }
}
