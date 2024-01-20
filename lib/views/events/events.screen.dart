import 'dart:convert';

import 'package:cible_controller/helpers/colorsHelpers.dart';
import 'package:cible_controller/models/Event.dart';
import 'package:cible_controller/views/scan/scan.screen.dart';
import 'package:cible_controller/views/tabs/en_cours/en_cours.screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:http/http.dart' as http;

import 'package:cible_controller/constants/api.dart';
import 'package:cible_controller/constants/local_path.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<Event>? events;
  bool isLoading = true;
  bool? countryIsSupport;

  Future<List<Event>?> getEventsFromAPI() async {
    try {
      var response = await http.get(
        Uri.parse('$baseApiUrl/events/scan/today-events'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final dynamic decodedBody = jsonDecode(response.body);

        if (decodedBody['success'] == true) {
          final List<dynamic> eventDataList = decodedBody['data'];

          List<Event> eventsList = eventDataList
              .map((dynamic eventJson) => Event.fromJson(eventJson))
              .toList();

          return eventsList;
        } else {
          print('API success is not true: $decodedBody');
          return null;
        }
      } else {
        print('API error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      List<Event>? fetchedEvents = await getEventsFromAPI();

      setState(() {
        events = fetchedEvents;
        isLoading = false; // Set loading state to false when data is available
      });
    } catch (e) {
      // Handle error if needed
      print('Error fetching events: $e');
      setState(() {
        isLoading = false; // Set loading state to false on error
      });
    }
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
              onPressed: () {},
              icon: const Icon(
                Icons.security,
                color: AppColor.primary,
                size: 30,
              ),
            )
          ],
        ),
        body: countryIsSupport != null && !countryIsSupport!
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
                color: Colors.black54,
              ),
            ),
          ),
        )
            : isLoading
            ? const Center(child: CircularProgressIndicator())
            : events == null || events!.isEmpty
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
                  EnCoursScreen(events: events!),
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
