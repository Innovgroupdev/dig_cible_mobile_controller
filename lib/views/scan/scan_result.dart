
import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/models/Event.dart';
import 'package:flutter/material.dart';

class ScanResult extends StatefulWidget {
  const ScanResult({Key? key});

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  List<Event>? events;
  bool isLoading = true; // Added to track loading state
  bool? countryIsSupport;

  late bool isBuildResult;
  late bool isQrValide;
  late String qrInformation;
  late dynamic tabQrInformation;
  late String codeQr;
  late String ticketAccessToken;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],

        body:  Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: 350,
                  child:  Icon(
                    isLoading ? Icons.check_circle : Icons.warning,
                    color: isLoading ? Colors.green : Colors.red,
                    size: 150,
                  ),
                ),
                 Text(
                  isLoading ? 'Code valide' : 'Code non valide',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
        )
      ),
    );
  }
}
