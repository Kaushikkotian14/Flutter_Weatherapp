import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather/pages/main_pages/listpage.dart';
import 'registration.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool _showPassword = false; // Add this line
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.grey[850], // For dark mode app bar color
      ),
      backgroundColor: Colors.grey[900], // For dark mode background color
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              style: TextStyle(color: Colors.white), // For dark mode text color
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white70), // For dark mode label color
                enabledBorder: OutlineInputBorder( // For dark mode border color
                  borderSide: BorderSide(color: Colors.white54),
                ),
                focusedBorder: OutlineInputBorder( // For dark mode focused border color
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              style: TextStyle(color: Colors.white), // For dark mode text color
              obscureText: !_showPassword, // Use the _showPassword state
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white70), // For dark mode label color
                enabledBorder: OutlineInputBorder( // For dark mode border color
                  borderSide: BorderSide(color: Colors.white54),
                ),
                focusedBorder: OutlineInputBorder( // For dark mode focused border color
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    // Change the icon based on the state of _showPassword
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white70, // For dark mode icon color
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey, // For a bit of color in dark mode
              ),
              onPressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if (user != null) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CityList()));
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationScreen()));
              },
              child: Text('Register', style: TextStyle(color: Colors.blueGrey)), // For visibility in dark mode
            ),
          ],
        ),
      ),
    );
  }
}
