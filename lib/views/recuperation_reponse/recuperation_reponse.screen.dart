import 'package:cible_controller/constants/local_path.dart';
import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/views/connexion/connexion.screen.dart';
import 'package:cible_controller/widgets/background.dart';
import 'package:flutter/material.dart';

class RecuperationReponseScreen extends StatefulWidget {
  const RecuperationReponseScreen({Key? key}) : super(key: key);

  @override
  _RecuperationReponseScreenState createState() =>
      _RecuperationReponseScreenState();
}

class _RecuperationReponseScreenState extends State<RecuperationReponseScreen> {
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
                  children: <Widget>[
                    const CircleAvatar(
                      maxRadius: 60.0,
                      backgroundImage: AssetImage('$imagesPath/s.jpeg'),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: const Text(
                        'RECUPERATION DE MOT DE PASSE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColor.text,
                        ),
                      ),
                    ),
                    const Text(
                      'Entrez votre nouveau mot de passe',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.text,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: TextFormField(
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
                            labelText: 'Nouveau mot de passe',
                            labelStyle: TextStyle(
                                color: AppColor.text,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            filled: true,
                            fillColor: AppColor.secondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: TextFormField(
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
                          labelText: 'Confirmation de mot de passe',
                          labelStyle: TextStyle(
                              color: AppColor.text,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
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
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const ConnexionScreen();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Valider',
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
      ),
    );
  }
}
