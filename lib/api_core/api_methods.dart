import 'dart:convert';
import 'package:http/http.dart' as http;

/// A utility class for making HTTP GET and POST requests.
///
/// The [ApiMethods] class provides methods to perform HTTP GET and POST
/// requests, with and without authentication tokens. It also includes a
/// static property for setting an API key.

class ApiMethods {
  /// An optional static API key used for requests requiring authentication.
  static String? xApiKey = "";

  /// Sends an HTTP GET request to the specified [url] with optional [headers].
  ///
  /// Returns a `Future` that completes with a `(int, Map<String, dynamic>)`
  /// containing the status code and the response data.
  ///
  /// Throws an exception if the request fails.
  ///
  /// Example usage:
  /// ```dart
  /// var response = await ApiMethods().getMethod(url: "https://api.example.com/data");
  /// ```
  Future<(int statusCode, Map<String, dynamic> data)> getMethod({
    String? url,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await http.get(
        Uri.parse(url ?? ""),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (error, stackTrace) {
      throw (error, stackTrace);
    }
  }

  /// Sends an HTTP GET request to the specified [url] with an authentication
  /// [token] and optional API key.
  ///
  /// Returns a `Future` that completes with a `(int, Map<String, dynamic>)`
  /// containing the status code and the response data.
  ///
  /// Throws an exception if the request fails.
  ///
  /// Example usage:
  /// ```dart
  /// var response = await ApiMethods().getMethodWithToken(url: "https://api.example.com/data", token: "your_token_here");
  /// ```
  Future<(int statusCode, Map<String, dynamic> data)> getMethodWithToken({
    String? url,
    var token,
  }) async {
    try {
      var response = await http.get(
        Uri.parse(url ?? ""),
        headers: (xApiKey ?? "").isNotEmpty
            ? {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
                'x-api-key': (xApiKey ?? ""),
              }
            : {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              },
      );
      return _handleResponse(response);
    } catch (error, stackTrace) {
      throw (error, stackTrace);
    }
  }

  /// Sends an HTTP POST request to the specified [url] with optional [headers]
  /// and request [body].
  ///
  /// Returns a `Future` that completes with a `(int, Map<String, dynamic>)`
  /// containing the status code and the response data.
  ///
  /// Throws an exception if the request fails.
  ///
  /// Example usage:
  /// ```dart
  /// var response = await ApiMethods().postMethod(url: "https://api.example.com/data", body: jsonEncode({"key": "value"}));
  /// ```
  Future<(int statusCode, Map<String, dynamic> data)> postMethod({
    String? url,
    Map<String, String>? headers,
    var body,
  }) async {
    try {
      var response = await http.post(
        Uri.parse(url ?? ""),
        headers: headers,
        body: body,
      );
      return _handleResponse(response);
    } catch (error, stackTrace) {
      throw (error, stackTrace);
    }
  }

  /// Sends an HTTP POST request to the specified [url] with an authentication
  /// [token], request [body], and optional API key.
  ///
  /// Returns a `Future` that completes with a `(int, Map<String, dynamic>)`
  /// containing the status code and the response data.
  ///
  /// Throws an exception if the request fails.
  ///
  /// Example usage:
  /// ```dart
  /// var response = await ApiMethods().postMethodWithToken(url: "https://api.example.com/data", token: "your_token_here", body: jsonEncode({"key": "value"}));
  /// ```
  Future<(int statusCode, Map<String, dynamic> data)> postMethodWithToken({
    String? url,
    var token,
    var body,
  }) async {
    try {
      var response = await http.post(
        Uri.parse(url ?? ""),
        headers: (xApiKey ?? "").isNotEmpty
            ? {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
                'x-api-key': (xApiKey ?? ""),
              }
            : {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              },
        body: body,
      );
      return _handleResponse(response);
    } catch (error, stackTrace) {
      throw (error, stackTrace);
    }
  }

  /// Handles the HTTP response and returns the response body as a `(int, Map<String, dynamic>)`.
  ///
  /// If the status code is 200, it returns the response body. Otherwise,
  /// it also returns the response body, assuming it contains error information.
  ///
  /// Throws a `FormatException` if the response body cannot be parsed.
  (int statusCode, Map<String, dynamic> data) _handleResponse(
      http.Response response) {
    if (response.statusCode == 200) {
      return (
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      return (
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }
  }
}
