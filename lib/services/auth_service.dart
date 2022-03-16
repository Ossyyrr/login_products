import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCHnkwZ7G01x09LhjFL9Wg7wb9TZ3mJk9s';
  final storage = const FlutterSecureStorage();

  /// En caso de error devuelve el error.
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: jsonEncode(authData));
    final Map<String, dynamic> decodeResp = jsonDecode(resp.body);
    log('AUTH:');
    log(decodeResp.toString());

    if (decodeResp.containsKey('idToken')) {
      // Guardar token  decodeResp['idToken'];
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  /// En caso de error devuelve el error.
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: jsonEncode(authData));
    final Map<String, dynamic> decodeResp = jsonDecode(resp.body);
    log('AUTH:');
    log(decodeResp.toString());

    if (decodeResp.containsKey('idToken')) {
      // Guardar token  decodeResp['idToken'];
      await storage.write(key: 'token', value: decodeResp['idToken']);

      log('LOGUEADO');
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
