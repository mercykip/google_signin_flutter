
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> startGoogleAuth() async {
    // Make a network request to initiate Google OAuth
    final response = await http.get(Uri.parse('http://192.168.1.18:8080/oauth2/authorization/google'));

    print('Google OAuth Login Initiated');
    print(response.body);
  }

  Future<void> callbackGoogle() async {
    // Handle callback after successful Google OAuth
    final response = await http.get(Uri.parse('http://192.168.1.18:8080/oauth2/callback/google'));

    print('Google OAuth Callback Response:');
    print(response.body);
  }
}