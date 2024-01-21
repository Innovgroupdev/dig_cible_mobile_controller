import 'dart:convert';

import 'package:cible_controller/helpers/dateHelper.dart';
import 'package:cible_controller/helpers/sharedPreferences.dart';
import 'package:cible_controller/providers/user_provider.dart';
import 'package:cible_controller/views/events/events.screen.dart';
import 'package:cible_controller/views/scan/scan.screen.dart';
import 'package:cible_controller/views/welcome/welcome.screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  dynamic deviceId;

  if (SharedPreferencesHelper.getIsNew() == null) {
    deviceId = await SharedPreferencesHelper().getDeviceIdFirst();
    print('deviceId: $deviceId');
    SharedPreferencesHelper.setDeviceId(deviceId!);
  } else {
    deviceId = SharedPreferencesHelper.getDeviceId();
    print('deviceId: $deviceId');
  }

  bool? isNew = SharedPreferencesHelper.getIsNew();
  runApp(MyApp(isNew: isNew, isTd: false,));
}

class MyApp extends StatefulWidget {
   MyApp({required this.isNew, required this.isTd, Key? key}) : super(key: key);

  final bool? isNew;
  bool? isTd;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic _storedData = "";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedData = prefs.getString('scan_result') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? jsonData;

    if (_storedData != null && _storedData.isNotEmpty) {
      try {
        jsonData = jsonDecode(_storedData);
      } catch (e) {
        // Handle the case when decoding fails
        print('Error decoding JSON: $e');
      }
    }

    if (jsonData != null) {
     widget.isTd = DateConvertisseur().isToday(jsonData['end_date']);

     print(widget.isTd);

    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Cible Scan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.green,
        ),
        home: widget.isNew != null ? widget.isTd == true ? const ScanScreen() : const EventsScreen() : const WelcomeScreen(),
      ),
    );
  }
}
