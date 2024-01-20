import 'dart:ui';

import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/models/Event.dart';
import 'package:cible_controller/views/scan/scan.screen.dart';
import 'package:cible_controller/widgets/toastError.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../constants/local_path.dart';
import '../../../widgets/raisedButtonDecor.dart';
import '../../events/eventDetails.controller.dart';

class MyCards extends StatelessWidget {
  final Widget image;
  final String name;
  final String lieu;
  final EventDate date;
  final String eventId;
  final _codeController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  FToast fToast = FToast();
  bool isLoading = false;
  MyCards(
      {super.key,
      required this.image,
      required this.name,
      required this.lieu,
      required this.date,
      required this.eventId});

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          debugPrint('Card tapped.');
          print(date);
        },
        child: SizedBox(
          width: double.maxFinite,
          height: 150,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0), child: image),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                color: AppColor.text,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              lieu.length > 50
                                  ? '${lieu.substring(0, 50)}...'
                                  : lieu,
                              style: const TextStyle(
                                color: AppColor.primary,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  DateFormat('d-MM-y').format(DateTime.parse(date.date)),
                                  style: const TextStyle(
                                    color: AppColor.text,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: ElevatedButton(

                                onPressed: (() async {
                                  await showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        true, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Container(
                                          constraints: BoxConstraints.expand(height: 400),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(height: 10.0),
                                                const CircleAvatar(
                                                  maxRadius: 30.0,
                                                  backgroundImage: AssetImage('$imagesPath/s.jpeg'),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 5.0),
                                                  child: const Text(
                                                    'CIBLE SCANNER',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                      color: AppColor.text,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Scanner les tickets des participants',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.text,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 30),
                                                Form(
                                                  key: _keyForm,
                                                  child: Expanded(
                                                    child: TextFormField(
                                                      controller: _codeController,
                                                      validator: (val) =>
                                                      val.toString().length < 5 && val.toString().isNotEmpty
                                                          ? 'Veuillez entrer un code valide !'
                                                          : null,
                                                      obscureText: true,
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.only(left: 20),
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
                                                        labelText: 'Saisir le code évènement',
                                                        labelStyle: TextStyle(
                                                          color: AppColor.text,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                        filled: true,
                                                        fillColor: AppColor.secondary,
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 40),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: OutlinedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          _codeController.clear();
                                                          isLoading = false;
                                                        },
                                                        style: OutlinedButton.styleFrom(
                                                          padding: const EdgeInsets.all(10),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          side: const BorderSide(width: 0.7, color: AppColor.primary),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: const [Text("Annuler")],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: StatefulBuilder(
                                                        builder: (BuildContext context1, StateSetter setState) {
                                                          return RaisedButtonDecor(
                                                            onPressed: isLoading ? () {} : () async {
                                                              if (_keyForm.currentState!.validate()) {
                                                                setState(() {
                                                                  isLoading = true;
                                                                });
                                                                bool isCodeCorrect = await verifyCode(
                                                                    _codeController.text, eventId);
                                                                setState(() {
                                                                  isLoading = false;
                                                                });
                                                                if (isCodeCorrect) {
                                                                  _codeController.clear();
                                                                  Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder: (BuildContext context) {
                                                                        return const ScanScreen();
                                                                      },
                                                                    ),
                                                                  );
                                                                } else {
                                                                  await showDialog<void>(
                                                                    context: context1,
                                                                    barrierDismissible:
                                                                    true, // user must tap button!
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        title: const Icon(
                                                                          Icons.warning,
                                                                          color: Colors.red,
                                                                          size: 50,
                                                                        ),
                                                                        content: const Text(
                                                                          'Code non valide',
                                                                          textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                            fontSize: 18,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          MaterialButton(
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius:
                                                                              BorderRadius.circular(10),
                                                                            ),
                                                                            color: AppColor.primary,
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: const Text(
                                                                              'OK',
                                                                              style: TextStyle(
                                                                                fontSize: 15,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            elevation: 0,
                                                            color: AppColor.primaryColor,
                                                            shape: BorderRadius.circular(10),
                                                            padding: const EdgeInsets.all(10),
                                                            child: isLoading
                                                                ? const SizedBox(
                                                                height: 20,
                                                                width: 20,
                                                                child: CircularProgressIndicator())
                                                                : const Text(
                                                              "Envoyer",
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                      );
                                    },
                                  );
                                }),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Scannez',
                                ),
                              ),
                            )
                          ],
                        ),
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
