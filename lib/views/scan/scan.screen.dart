import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/helpers/sharedPreferences.dart';
import 'package:cible_controller/views/events/eventDetails.controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late bool isQrValide;
  late String ticketCode;

  Completer<void> _cameraPausedCompleter = Completer<void>();


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQRScannerWidget(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: FutureBuilder<bool?>(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            return Icon(snapshot.data ?? false ? Icons.flash_on : Icons.flash_off);
                          },
                        ),
                        onPressed: () async {
                          final flashStatus = await controller?.getFlashStatus() ?? false;
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQRScannerWidget(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((scanData) async {

      setState(() {
        ticketCode = scanData.code.toString();
        _pauseCamera();

      });
      await verifyCodeQr(ticketCode, ' ').then((value) {
        setState(() {
          isQrValide = value;
          result = scanData;
          _showResultDialog();
        });
        //controller.resumeCamera();
      });
    });

  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Future<void> _pauseCamera() async {
    controller?.pauseCamera();
    await Future.delayed(Duration(seconds: 1)); // Add a delay if needed
    _cameraPausedCompleter.complete();
  }


  Future<void> _resumeCamera() async {
    controller?.resumeCamera();
    await Future.delayed(Duration(seconds: 1)); // Add a delay if needed
    _cameraPausedCompleter.complete();
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            isQrValide ? Icons.check_circle : Icons.warning,
            color: isQrValide ? Colors.green : Colors.red,
            size: 50,
          ),
          content: Text(
            isQrValide ? 'Code valide' : 'Code non valide',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            MaterialButton(
              color: AppColor.primary,
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() async {
                  await _resumeCamera();
                  result = null;
                });
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
