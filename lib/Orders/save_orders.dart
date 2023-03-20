import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pepess_pizza/dishes/dishes_list.dart';

import '../Cart/cart_model.dart';

Future<List<dynamic>> SaveOrders({
  required String registrationId,
  required List<CartItem> cartList,
  required String takeAwayTime,
}) async {
  String urlPOSTorder = API.SaveOrders;
  Map<String, String> headers = {"Content-type": "application/json"};
  var SaveOrders = List<dynamic>.from(cartList.map((x) => x.toJson()));

  var request = http.Request(
      'POST',
      Uri.parse(
          'https://pepespizza-api.azurewebsites.net:443//api/Customer/SaveOrder'));
  request.body = json.encode({
    "hotel_id": 1,
    "customer_id": 2,
    "dishid_qty_list": [
      {"dish_id": 1, "qty": 2}
    ]
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
