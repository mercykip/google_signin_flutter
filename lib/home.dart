import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth_service.dart';

class SignInPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? account;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  Future<void> _handleSignIn() async {
    try {
      print('Step 1');
      final GoogleSignInAccount? account =
          await _googleSignIn.signIn().then((value) {
        print('Step 2');
        value?.authentication.then((auth) async {
          print('Step 3');

          final idToken = auth.idToken;
          if (idToken != null) {
            await sendAuthToken(idToken);
            print('Step 4');
          } else {
            print('Step 5');
          }
        });
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> sendAuthToken(String authToken) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.18:8090/verify-google-token'),
      body: authToken,
      headers: {'Content-Type': 'application/json'},
    );
    print('Status Code '+response.statusCode.toString() );
    if (response.statusCode == 200) {
      print('Token verified');
    } else {
      print('Token verification failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignIn,
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
