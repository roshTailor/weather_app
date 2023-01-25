import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/utils/apiString.dart';

class HttpService {
  Future getWeatherResponse() async {
    Response res = await get(Uri.parse(ApiString.weatherUrl + ApiString.city + ApiString.appId + ApiString.apiKey));
    if(res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(data);
      return data;
    } else {
      print(res.statusCode);
    }
  }
}