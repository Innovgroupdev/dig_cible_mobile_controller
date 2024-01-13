import 'package:cible_controller/constants/local_path.dart';
import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/views/recuperation_reponse/recuperation_reponse.screen.dart';
import 'package:cible_controller/widgets/background.dart';
import 'package:flutter/material.dart';

class RecuperationScreen extends StatefulWidget {
  const RecuperationScreen({super.key});

  @override
  State<RecuperationScreen> createState() => _RecuperationScreenState();
}

class _RecuperationScreenState extends State<RecuperationScreen> {
  bool isLoading = false;
  
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
                    const Text(
                      'RECUPERATION DE MOT DE PASSE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColor.text,
                      ),
                    ),
                    const Text(
                      'Entrez votre email',
                      style: TextStyle(
                        color: AppColor.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(137, 160, 195, 176),
                                width: 3.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(137, 160, 195, 176),
                                width: 0.0),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: AppColor.text,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(137, 160, 195, 176),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const RecuperationReponseScreen();
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
                          'Récuperer',
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
