import 'dart:convert';
import 'package:cible_controller/constants/api.dart';
import 'package:http/http.dart' as http;

import '../../helpers/sharedPreferences.dart';
import '../../models/Event.dart';

bool getCategorieIsMultiple(code) {
  List listMultiple = ['FOIR', 'FES', 'EXP'];
  return listMultiple.contains(code);
}

getCategorieIsCinema(code) {
  return code == 'CINE';
}

verifyCode(String code, int eventId) async {
  print(eventId);
  dynamic deviceId = SharedPreferencesHelper.getDeviceId();
  Map<String, dynamic> data = {"code": code, "device_token": deviceId};
  try {
    var response = await http.post(
        Uri.parse('$baseApiUrl/events/verifycode/$eventId'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(data));
    print(jsonEncode(data));

    print(response.body);
    var finalData = jsonDecode(response.body) as Map;
    if (finalData['status'] == "success") {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Erroree $e');
    return false;
  }
}

Future<bool> verifyCodeQr(
    String codeInformation, String ticketAccessToken) async {
  Map<String, dynamic> data = {
    "code_informations": codeInformation,
  };
  try {
    var response = await http.post(Uri.parse('$baseApiUrl/code/validate'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $ticketAccessToken",
        },
        body: jsonEncode(data));
    print('livliccccccccccccccc' + response.body.toString());
    var finalData = jsonDecode(response.body) as Map;
    if (finalData['status'] == "sucess") {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Erroree $e');
    return false;
  }
}
