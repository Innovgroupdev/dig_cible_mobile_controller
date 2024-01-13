import 'package:cible_controller/helpers/sharedPreferences.dart';
import 'package:cible_controller/providers/user_provider.dart';
import 'package:cible_controller/views/events/events.screen.dart';
import 'package:cible_controller/views/main/main.screen.dart';
import 'package:cible_controller/views/welcome/welcome.screen.dart';
import 'package:flutter/material.dart';
import 'package:cible_controller/core/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  dynamic deviceId;
  if(SharedPreferencesHelper.getIsNew() == null){
  await SharedPreferencesHelper().getDeviceIdFirst().then((value) {
    deviceId = value;
  }) ;
  print('deviceeId '+deviceId );
    SharedPreferencesHelper.setDeviceId(deviceId);
  }else{
    dynamic deviceId = SharedPreferencesHelper.getDeviceId();
     print('deviceeId '+deviceId );
  }

  bool? isNew = SharedPreferencesHelper.getIsNew();
  runApp(MyApp(isNew: isNew,));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.isNew, super.key});
  final bool? isNew;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.green,
        ),
        // routes: routes,
        // initialRoute: '/',
        // onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        home: isNew == null?
        const WelcomeScreen():
        const EventsScreen(),
      ),
    );
  }
}
