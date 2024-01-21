import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cible_controller/constants/api.dart';
import 'package:cible_controller/helpers/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<bool> verifyCode(String code, String eventId) async {
  dynamic deviceId = SharedPreferencesHelper.getDeviceId();
  Map<String, dynamic> data = {"code_scan": code, "device_token": deviceId};

  try {
    var response = await http.post(
      Uri.parse('$baseApiUrl/events/scan/verify-scan-code/$eventId'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    var jsonResponse = response.body;

    var finalData = jsonDecode(jsonResponse) as Map<String, dynamic>;
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString('scan_result', jsonEncode(finalData['data']));
    });


    return finalData['success'] == true;
  } catch (e) {
    print('Error: $e');
    return false;
  }
}





Future<Map<String, dynamic>> verifyCodeQr(String ticketCode, String eventDate) async {
  final eventData = await SharedPreferencesHelper.readScanResult();
  eventDate = eventData['end_date'];

  Map<String, dynamic> data = {"code": ticketCode, "event_date": eventDate};
  try {
    var response = await http.post(
      Uri.parse('$baseApiUrl/tickets/scan'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        // Uncomment the line below if needed
        // "Authorization": "Bearer $ticketAccessToken",
      },
      body: jsonEncode(data),
    );

    print('res' + response.body.toString());
    var finalData = jsonDecode(response.body) as Map<String, dynamic>;

    return finalData;

  } catch (e) {
    print('Error: $e');
    // Return an appropriate error message or handle the error as needed
    throw Exception('Error occurred: $e');
  }
}

