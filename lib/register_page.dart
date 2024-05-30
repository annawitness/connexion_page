// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> registerUser(String nom, String prenom, String email,
      String password, String phone) async {
    final String url =
        'http://192.168.252.147/register'; // Changez localhost par l'IP locale si nécessaire

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'password': password,
        'phone': phone,
      }),
    );

    if (response.statusCode == 200) {
      print('Inscription réussie');
    } else {
      print('Échec de l\'inscription: ${response.body}');
    }
  }

  Future<void> _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await registerUser(
        _nomController.text,
        _prenomController.text,
        _emailController.text,
        _passwordController.text,
        _phoneController.text,
      );

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Succès'),
          content: Text('Inscription réussie'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erreur'),
          content: Text('Échec de l\'inscription. Veuillez réessayer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire d\'inscription'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 370,
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.only(top: 80),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          controller: _nomController,
                          decoration: const InputDecoration(
                            labelText: 'Nom',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre nom';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          controller: _prenomController,
                          decoration: const InputDecoration(
                            labelText: 'Prénoms',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer vos prénoms';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Contact',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre numéro de téléphone';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Veuillez entrer un email valide';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Mot de Passe',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer un mot de passe';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: TextFormField(
                          controller: _password2Controller,
                          decoration: const InputDecoration(
                            labelText: 'Confirmez le mot de Passe',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez confirmer votre mot de passe';
                            } else if (value != _passwordController.text) {
                              return 'Les mots de passe ne correspondent pas';
                            }
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _submitForm(context),
                        child: const Text('Envoyer'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
