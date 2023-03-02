import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pepess_pizza/dishes/screens/home_screen.dart';
import 'package:pepess_pizza/login_response.dart';
import 'package:pepess_pizza/dishes/dishes_list.dart';
import 'config.dart';

class DishpageJason {
  DishpageJason(String body);
}

class APIService {
  static var client = http.Client();

  static Future<LoginResponseModel> otpLogin(String mobileNo) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.otpLoginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"phone": mobileNo}),
    );

    return loginResponseJson(response.body);
  }

  static Future<LoginResponseModel> verifyOtp(
    String mobileNo,
    String otpHash,
    String otpCode,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.verifyOTPAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"phone": mobileNo, "otp": otpCode}),
    );

    return loginResponseJson(response.body);
  }

  static Future<DishpageJason> GetDishesByHotelAPI(
      int dish_id, String dish_name) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.GetDishesByHotelAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"id": dish_id, "name": dish_name}),
    );

    return DishpageJason(response.body);
  }
}
