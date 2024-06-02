import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              onPressed: () => _login(context),
              child: Text('Login'),
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

  void _login(BuildContext context) async {
    if (_validateEmail(_emailController.text) && _validatePassword(_passwordController.text)) {
      try {
        await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
        // certo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Funcionou!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        // erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Falhou!')),
        );
      }
    }
  }
}