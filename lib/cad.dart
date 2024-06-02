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
        title: Text('Cadastrar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _validateEmail(_emailController.text) ? null : 'Por favor, coloque um email valido',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _validatePassword(_passwordController.text) ? null : 'A senha precisa de pelo menos 6 caracteres',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signUp(context),
              child: Text('Cadastrar'),
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
      }
    }
  }
}