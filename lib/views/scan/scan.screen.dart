import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../events/eventDetails.controller.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  bool isBuildResult = false;
  bool? isQrValide;

  String? qrInformation;
          dynamic? tabQrInformation;
          String? codeQr;
          String? ticketAccessToken;

  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Theme.of(context).platform == TargetPlatform.android) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            buildQrView(context),
            //isBuildResult == true || 
            barcode != null?
            Center(
              child: buildResult(),
            ):const SizedBox(),
            Positioned(bottom: 150, child: buildControlButton()),
          ],
        ),
      ),
    );
  }

  Widget buildControlButton() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Icon(
                          snapshot.data! ? Icons.flash_on : Icons.flash_off);
                    } else {
                      return Container();
                    }
                  }),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
            ),
          ],
        ),
      );

  Widget buildResult() {
    if (barcode != null) {
      return AlertDialog(
        title: 
        isQrValide == true ?
        const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 50,
        ):
        const Icon(
          Icons.warning,
          color: Colors.red,
          size: 50,
        ),
        content: Text(
          isQrValide == true ? 'Code valide' : 'Code non valide',
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
              setState(() {
                barcode = null;
                isBuildResult = false;
              });
            //  Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated:
        // isBuildResult == false?
        onQRViewCreated,
        //:
       // ((p0) {print('aaaaaaaaaaaaaaaaaaaaa'+isBuildResult.toString());}),
        overlay: QrScannerOverlayShape(
          borderLength: 10,
          borderRadius: 10,
          borderWidth: 10,
          borderColor: AppColor.primary,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    // isBuildResult == true?
    // controller.pauseCamera():null;

    controller.scannedDataStream.listen((barcodee)async{ 
      print('aaaaaaaaaaaaaaaaaaaaa'+isBuildResult.toString());
      setState(() {
          
          qrInformation = barcodee.code.toString();
          tabQrInformation = qrInformation!.split(' ');
          codeQr = tabQrInformation[0];
          ticketAccessToken = tabQrInformation[1];
          
          
        });
        await verifyCodeQr(codeQr!,ticketAccessToken!).then((value) {
          setState(() {
            isQrValide = value;
            isBuildResult = true;
            this.barcode = barcodee;
          });
        } );
        
        }


    // controller.scannedDataStream.listen((barcodee)async{ 
    //   print('aaaaaaaaaaaaaaaaaaaaa'+isBuildResult.toString());
    //   setState(() {
          
    //       qrInformation = barcodee.code.toString();
    //       tabQrInformation = qrInformation!.split(' ');
    //       codeQr = tabQrInformation[0];
    //       ticketAccessToken = tabQrInformation[1];
          
          
    //     });
    //     await verifyCodeQr(codeQr!,ticketAccessToken!).then((value) {
    //       setState(() {
    //         isQrValide = value;
    //         isBuildResult = true;
    //         this.barcode = barcodee;
    //       });
    //     } );
        
    //     }
        );
  }
}
