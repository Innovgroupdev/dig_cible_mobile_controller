import 'dart:convert';

import 'package:cible_controller/helpers/sharedPreferences.dart';
import 'package:cible_controller/providers/user_provider.dart';
import 'package:cible_controller/views/events/events.screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cible_controller/constants/local_path.dart';
import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/views/recuperation/recuperation.screen.dart';
import 'package:cible_controller/widgets/background.dart';
import 'package:provider/provider.dart';

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailController.text = SharedPreferencesHelper.getEmail() ?? '';
    _passwordController.text = SharedPreferencesHelper.getPassword() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      maxRadius: 60.0,
                      backgroundImage: AssetImage('$imagesPath/s.jpeg'),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'CONNEXION',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: AppColor.text),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.secondary,
                              width: 3.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.secondary,
                            ),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColor.text,
                          ),
                          filled: true,
                          fillColor: AppColor.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.secondary, width: 3.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.secondary, width: 0.0),
                          ),
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(
                            color: AppColor.text,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColor.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Se Connecter',
                                style: TextStyle(fontSize: 20.0),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const RecuperationScreen();
                          }),
                        );
                      },
                      child: const Text(
                        'J\'ai oublié mon mot de passe',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (_passwordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      var response = await http.post(
        Uri.parse(
            "http://backend.cible-app.com/public/api/auth/controllers/login"),
        body: ({
          'email': _emailController.text,
          'password': _passwordController.text
        }),
      );

      print(SharedPreferencesHelper.getToken());

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final Map body = json.decode(response.body);

        await SharedPreferencesHelper.setEmail(_emailController.text);
        await SharedPreferencesHelper.setPassword(_passwordController.text);
        await SharedPreferencesHelper.setToken(body['access_token']);

        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false)
            .setEmail(SharedPreferencesHelper.getEmail() ?? '');
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false)
            .setPassword(SharedPreferencesHelper.getPassword() ?? '');
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false)
            .setToken(SharedPreferencesHelper.getToken() ?? '');

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) {
            return const EventsScreen();
          }),
        );
      } else {
        print(response.body);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email ou mot de passe incorrect")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Remplissez les champs")),
      );
    }
  }
}
