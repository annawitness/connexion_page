// ignore_for_file: prefer_const_constructors

import 'package:connexion_page/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Page de connexion'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: LoginPage(),
      ),
    );
  }
}
