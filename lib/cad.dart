import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'log.dart';

class SignUpPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _validateEmail(_emailController.text) ? null : 'Please enter a valid email',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _validatePassword(_passwordController.text) ? null : 'Password needs at least 6 characters',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signUp(context),
              child: Text('Sing Up Now!'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateEmail(String email) {
    return email.contains('@');
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  void _signUp(BuildContext context) async {
    if (_validateEmail(_emailController.text) && _validatePassword(_passwordController.text)) {
      try {
        await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created! Please log-in!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
      }
    }
  }
}