import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:pepess_pizza/Cart/cart_response.dart';

class FlutterCart {
  static final FlutterCart _instance = FlutterCart._internal();
  late CartItem _cartItem;
  // CartItemElement _cartItemElement;
  late List<CartItem> _cartItemList;
  List<CartItem> get cartItem => _cartItemList;
  late List<String> dish_id;
  bool _filterItemFound = false;
  late CartResponse message;
  factory FlutterCart() {
    return _instance;
  }
  FlutterCart._internal() {
    _cartItemList = <CartItem>[];
    dish_id = [];
  }

  addToCart(
      {@required dynamic dish_id,
      @required dynamic rate,
      String? dish_name,
      int quantity = 1,
      dynamic uniqueCheck,
      dynamic productDetailsObject}) {
    _cartItem = new CartItem();
    _setProductValues(
        dish_id, rate, dish_name, quantity, uniqueCheck, productDetailsObject);
    if (_cartItemList.isEmpty) {
      _cartItem.subTotal = double.parse((quantity * rate).toStringAsFixed(2));
      dish_id.add(_cartItem.dish_id);
      _cartItemList.add(_cartItem);

      message = CartResponse(true, _successMessage, _cartItemList);
      return message;
    } else {
      _cartItemList.forEach((x) {
        if (x.dish_id == dish_id) {
          if (uniqueCheck != null) {
            if (x.uniqueCheck == uniqueCheck) {
              _filterItemFound = true;
              _updateProductDetails(x, quantity, rate);
              /* message = {
                "status": true,
                "message": _updateMessage,
                "data": _cartItemList,
                "length": _cartItemList.length
              }; */
              message = CartResponse(true, _updateMessage, _cartItemList);
            }
          } else {
            _filterItemFound = true;
            _updateProductDetails(x, quantity, rate);
            message = CartResponse(true, _successMessage, _cartItemList);
          }
        }
      });

      if (!_filterItemFound) {
        dish_id.add(_cartItem.dish_id);
        _updateProductDetails(_cartItem, quantity, rate);
        _cartItemList.add(_cartItem);
        message = CartResponse(true, _successMessage, _cartItemList);
      }
      _filterItemFound = false;
      return message;
    }
  }

  decrementItemFromCart(int index) {
    if (_cartItemList[index].quantity > 1) {
      _cartItemList[index].quantity = --_cartItemList[index].quantity;
      _cartItemList[index].subTotal =
          (_cartItemList[index].quantity * _cartItemList[index].unitPrice)
              .roundToDouble();
    } else {
      _cartItemList.removeAt(index);
      return CartResponse(true, _removedMessage, _cartItemList);
      // return true;
    }
    return CartResponse(true, _removedMessage, _cartItemList);
  }

  deleteItemFromCart(int index) {
    for (int i = _cartItemList[index].quantity; i > 0; i--) {
      decrementItemFromCart(index);
    }
    message = CartResponse(true, _successMessage, _cartItemList);
    return message;
  }

  deleteAllCart() {
    _cartItemList = <CartItem>[];
    dish_id = <String>[];
  }

  int? findItemIndexFromCart(hotel_id) {
    for (int i = 0; i < _cartItemList.length; i++) {
      if (_cartItemList[i].dish_id == hotel_id) {
        return i;
      }
    }
    return null;
  }

  CartItem? getSpecificItemFromCart(hotel_id) {
    for (int i = 0; i < _cartItemList.length; i++) {
      if (_cartItemList[i].dish_id == hotel_id) {
        _cartItemList[i].itemCartIndex = i;
        return _cartItemList[i];
      }
    }
    return null;
  }

  incrementItemToCart(int index) {
    _cartItemList[index].quantity = ++_cartItemList[index].quantity;
    _cartItemList[index].subTotal =
        (_cartItemList[index].quantity * _cartItemList[index].unitPrice)
            .roundToDouble();

    return CartResponse(true, _successMessage, _cartItemList);
  }

  void _setProductValues(productId, unitPrice, productName, int quantity,
      uniqueCheck, productDetailsObject) {
    _cartItem.uuid =
        productId.toString() + "-" + DateTime.now().toIso8601String();
    _cartItem.productId = productId;
    _cartItem.unitPrice = unitPrice;
    _cartItem.productName = productName;
    _cartItem.quantity = quantity;
    _cartItem.uniqueCheck = uniqueCheck;
    _cartItem.productDetails = productDetailsObject;
  }

  void _updateProductDetails(cartObject, int quantity, dynamic unitPrice) {
    cartObject.quantity = quantity;
    cartObject.subTotal =
        double.parse((quantity * unitPrice).toStringAsFixed(2));
  }

  getCartItemCount() {
    return _cartItemList.length;
  }

  getTotalAmount() {
    double totalAmount = 0.0;
    _cartItemList.forEach((e) => totalAmount += e.subTotal);
    return totalAmount;
  }

  static final String _successMessage = "Item added to cart successfully.";
  static final String _updateMessage = "Item updated successfully.";
  static final String _removedMessage = "Item removed from cart successfully.";
}
