import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderList {
  final int currentPage;
  final List<Data> datas;

  OrderList({required this.currentPage, required this.datas});

  factory OrderList.fromJson(Map<int, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    print(list.runtimeType);
    List<Data> datalist = list.map((i) => Data.fromJson(i)).toList();

    return OrderList(currentPage: parsedJson['current_page'], datas: datalist);
  }
}

class Data {
  int Customer_id;

  Data.fromJson(Map<int, dynamic> jsonMap) {
    this.Customer_id = jsonMap['Customer_id'];
  }
}

class ActiveOrder {
  // final int orderId;
  // final String totalAmount;
  // final String restaurantName;
  // final String date;
  final List<OrderList> orders;

  //ActiveOrder({this.orderId, this.totalAmount, this.restaurantName, this.date});
  ActiveOrder({required this.orders});

  factory ActiveOrder.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['orderList'] as List;
    print(list.runtimeType);
    List<OrderList> orderList = list.map((i) => OrderList.fromJson(i)).toList();

    return ActiveOrder(orders: orderList);
  }
}

class ActiveOrdersListView extends StatelessWidget {
  ActiveOrdersListView(String body);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ActiveOrder>>(
      future: _fetchOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ActiveOrder>? data = snapshot.data;
          return _ordersListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  ListView _ordersListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          //   return _tile(
          //       data[index].restaurantName, data[index].orderId, Icons.work);
          // });
          return _tile("Test heading", "Test Subheading", Icons.work);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );
}
