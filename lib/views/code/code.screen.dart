import 'dart:convert';

import 'package:cible_controller/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cible_controller/constants/local_path.dart';
import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/views/connexion/connexion.screen.dart';
import 'package:cible_controller/views/inscription/inscription.screen.dart';
import 'package:cible_controller/views/welcome/welcome.screen.dart';
import 'package:cible_controller/widgets/background.dart';

import '../scan/scan.screen.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final _codeController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 110.0,
                    ),
                    const CircleAvatar(
                      maxRadius: 60.0,
                      backgroundImage: AssetImage('$imagesPath/s.jpeg'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: const Text(
                        'CIBLE SCANNER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: AppColor.text,
                        ),
                      ),
                    ),
                    const Text(
                      'Scanner les tickets des participants',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.text,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: _codeController,
                        obscureText: true,
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
                              width: 0.0,
                            ),
                          ),
                          labelText: 'Code évènement',
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
                      height: 40.0,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: 
                        //checkCode,
                         () {
                           Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) {
            return const ScanScreen();
            // return InscriptionScreen(email: body['data']);
          }));
                        //   Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(builder: (BuildContext context) {
                        //       return const InscriptionScreen();
                        //     }),
                        //   );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Soumettre',
                                style: TextStyle(fontSize: 20.0),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }

  Future<void> checkCode() async {
    if (_codeController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      var response = await http.post(
        Uri.parse("http://backend.cible-app.com/public/api/verifycode"),
        body: ({
          "code": _codeController.text,
        }),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final Map body = json.decode(response.body);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) {
            return const ScanScreen();
            // return InscriptionScreen(email: body['data']);
          }),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Code incorrect")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Remplir les champs")),
      );
    }
  }
}
