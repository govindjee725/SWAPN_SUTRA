import 'package:dream_verse/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:dream_verse/screen/login_screen.dart'; // Your LoginPage
import 'package:dream_verse/screen/signup_screen.dart'; // Your SignupPage
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwapnaSutra',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // 👈 Start with LoginScreen
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomeScreen(), 
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to SwapnaSutra'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
