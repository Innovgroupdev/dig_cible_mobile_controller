import 'dart:convert';

import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/helpers/sharedPreferences.dart';
import 'package:cible_controller/views/settings/settings.screen.dart';
import 'package:cible_controller/views/tabs/en_cours/en_cours.screen.dart';
import 'package:cible_controller/views/tabs/historique/historique.screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:http/http.dart' as http;

import '../../constants/api.dart';
import '../../constants/local_path.dart';
import '../../helpers/countriesJsonHelper.dart';
import '../../models/categorie.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<Categorie>? categories;

  String countryCode = '';
  String countryLibelle = '';
  var countryIsSupport;

  getCategoriesFromAPI() async {
    var response = await http.get(
      Uri.parse('$baseApiUrl/events_of_day/$countryLibelle'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    );
    print('lallllllllllllllll' + jsonDecode(response.body).toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        countryIsSupport = true;
        if (jsonDecode(response.body)['data'] != null) {
          categories =
              getCategorieFromMap(jsonDecode(response.body)['data'] as List);
        } else {
          categories = [];
        }
      });
      return categories;
    } else if (response.statusCode == 500) {
      setState(() {
        countryIsSupport = false;
      });
    }
  }

  Future getUserLocation() async {
    var response = await http.get(
      Uri.parse('https://ipinfo.io/json'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    );
    if (response.statusCode == 200) {
      // print(object)
      setState(() {
        countryCode = jsonDecode(response.body)['country'];
        countryLibelle = getCountryDialCodeWithCountryCode(countryCode);
      });
    }
  }

  getCategorieFromMap(List categorieListFromAPI) {
    final List<Categorie> tagObjs = [];
    for (var element in categorieListFromAPI) {
      var categorie = Categorie.fromMap(element);
      if (categorie.events.isNotEmpty) {
        tagObjs.add(categorie);
      }
    }
    return tagObjs;
  }

  @override
  void initState() {
    getUserLocation().then((value) => {getCategoriesFromAPI()});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          foregroundColor: AppColor.primary,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: const CircleAvatar(
              maxRadius: 80.0,
              backgroundImage: AssetImage('$imagesPath/s.jpeg'),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: const Text(
            'EVENEMENTS',
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (BuildContext context) {
                //     return const SettingsScreen();
                //   }),
                // );
              },
              icon: const Icon(
                Icons.security,
                color: AppColor.primary,
                size: 30,
              ),
            )
          ],
        ),
        body: countryIsSupport != null && !countryIsSupport
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Text(
                    "Désolé, CIBLE n'est pas disponible dans votre pays pour le moment."
                    "Nous travaillons à son lancement très bientôt."
                    "Merci et à très bientôt."
                    "❤️",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              )
            : categories == null
                ? const Center(child: CircularProgressIndicator())
                : categories!.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 350,
                                width: 350,
                                child: Image.asset('$imagesPath/empty.png'),
                              ),
                              const Text(
                                'Pas d\'évènements aujourd\'hui',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: AppColor.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            TabBar(
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 20),
                              labelColor: AppColor.primary,
                              unselectedLabelColor: AppColor.secondary,
                              labelStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              indicator: DotIndicator(
                                color: AppColor.primary,
                                distanceFromCenter: 16,
                                radius: 5,
                                paintingStyle: PaintingStyle.fill,
                              ),
                              tabs: const [
                                Tab(text: 'En cours'),
                                //Tab(text: 'Historique'),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                EnCoursScreen(categories: categories!),
                                // HistoriqueScreen(),
                              ]),
                            )
                          ],
                        ),
                      ),
      ),
    );
  }
}
