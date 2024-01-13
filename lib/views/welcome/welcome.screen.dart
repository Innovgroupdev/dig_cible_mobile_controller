import 'package:cible_controller/constants/local_path.dart';
import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/helpers/sharedPreferences.dart';
import 'package:cible_controller/views/code/code.screen.dart';
import 'package:cible_controller/widgets/background.dart';
import 'package:flutter/material.dart';

import '../events/events.screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
@override
  void initState() {
    SharedPreferencesHelper.init();
    SharedPreferencesHelper.setIsNew(true);
    
    super.initState();
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: const Text(
                        'CIBLE SCANNER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: AppColor.text,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: const CircleAvatar(
                        maxRadius: 80.0,
                        backgroundImage: AssetImage('$imagesPath/s.jpeg'),
                      ),
                    ),
                    const Text(
                      'Scannez les tickets de vos événements publiés sur CIBLE',
                      style: TextStyle(
                        fontSize: 18,
                        height: 2,
                        color: AppColor.text,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const EventsScreen();
                          }),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(padding: EdgeInsets.only(right: 70.0)),
                          Text(
                            'Commencez',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 24.0,
                          ),
                          Padding(padding: EdgeInsets.only(left: 70.0))
                        ],
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
