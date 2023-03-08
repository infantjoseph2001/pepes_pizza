import 'package:flutter_cart/model/cart_model.dart';

class CartResponse {
  final bool status;
  final String message;
  List<CartItem> cartDishList;
  final int price = 75;

  CartResponse(this.status, this.message, this.cartDishList);
}
