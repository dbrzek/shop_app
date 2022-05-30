import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  static const params = {
    'key': 'AIzaSyAnGNZCaSxZoJ52iy5jn43du_-OV5Fi0K8',
  };

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url = Uri.https(
      'identitytoolkit.googleapis.com',
      '/v1/$urlSegment',
      params,
    );
    // https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
    // https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      print(response.statusCode);
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpExceptetion(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(
    String email,
    String password,
  ) async {
    return _authenticate(
      email,
      password,
      'accounts:signUp',
    );
    // final url = Uri.https('identitytoolkit.googleapis.com',
    //     '/v1/accounts:signInWithCustomToken?key=AIzaSyAnGNZCaSxZoJ52iy5jn43du_-OV5Fi0K8');

// https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]
    // Web API key:  identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyAnGNZCaSxZoJ52iy5jn43du_-OV5Fi0K8
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    return _authenticate(
      email,
      password,
      'accounts:signInWithPassword',
    );
  }
}
