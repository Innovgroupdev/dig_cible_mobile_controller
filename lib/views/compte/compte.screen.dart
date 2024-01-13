import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/helpers/sharedPreferences.dart';
import 'package:cible_controller/providers/user_provider.dart';
import 'package:cible_controller/views/settings/settings.widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompteScreen extends StatefulWidget {
  const CompteScreen({Key? key}) : super(key: key);

  @override
  _CompteScreenState createState() => _CompteScreenState();
}

class _CompteScreenState extends State<CompteScreen> {
  final _nomController = TextEditingController();
  final _prenomsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nomController.text = SharedPreferencesHelper.getNom() ?? '';
    _prenomsController.text = SharedPreferencesHelper.getPrenoms() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          foregroundColor: AppColor.primary,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'MON COMPTE',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ProfileInfo(),
                SizedBox(height: 20),
                SizedBox(
                  child: TextFormField(
                    controller: _nomController,
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
                      labelText: 'Nom',
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
                    controller: _prenomsController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.secondary, width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.secondary, width: 0.0),
                      ),
                      labelText: 'Prénoms',
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
                    onPressed: update,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Soumettre',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }

  Future update() async {
    await SharedPreferencesHelper.setNom(_nomController.text);
    await SharedPreferencesHelper.setPrenoms(_prenomsController.text);

    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false)
        .setNom(SharedPreferencesHelper.getNom() ?? '');

    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false)
        .setPrenoms(SharedPreferencesHelper.getPrenoms() ?? '');
  }
}
