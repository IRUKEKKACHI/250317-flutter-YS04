import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ys04_20250317/service/AuthService.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginScreen = true;
  final authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showAlert(String title, String content) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }

  String _messageParser(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'weak-password':
        errorMessage = 'Password shoud be at least 6 characters';
        break;
      case 'email-already-in-use':
        errorMessage =
            'The email address is already in use by another account.';
        break;
      default:
        errorMessage = 'An unknown error occured';
    }
    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text;
                try {
                  if (isLoginScreen) {
                    // Login
                    final userCredential =
                        await authService.signIn(email, password);
                    await _showAlert(
                        'Login Success', 'You have logged in successfully.');
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // SignUp
                    final userCredential =
                        await authService.signUp(email, password);
                    await _showAlert('Sign Up Success',
                        'Your account has been created successfully.');
                    Navigator.pushReplacementNamed(context, '/auth');
                  }
                } on FirebaseAuthException catch (e) {
                  _showErrorSnackBar(_messageParser(e));
                  print(e);
                } catch (e) {
                  _showErrorSnackBar('An unknown error occurred');
                  print(e);
                }
              },
              child: Text(isLoginScreen ? 'Login' : 'Sign Up'),
            ),
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  isLoginScreen = !isLoginScreen;
                  emailController.clear();
                  passwordController.clear();
                });
              },
              child: Text(isLoginScreen
                  ? 'Don\'t have an account? Sign Up'
                  : 'Already have an account? Login'),
            )
          ],
        ),
      ),
    );
  }
}
