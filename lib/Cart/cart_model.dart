import 'dart:convert';

class CartItem {
  CartItem(
      {required this.dish_id,
      required this.image,
      required this.dish_name,
      this.subTotal,
      this.quantity = 0,
      required this.thumbnail,
      required this.Description,
      required this.rate,
      required itemCartIndex});

  int dish_id;
  String dish_name;
  String image;
  String thumbnail;
  String Description;
  double rate;
  dynamic subTotal;
  int quantity;
  // Item store on which index of cart so we can update or delete cart easily, initially it is -1
  int itemCartIndex;

  factory CartItem.fromJson(String str) => CartItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
        dish_id: json["Dish_id"],
        dish_name: json["Dish_name"],
        image: json["Dish_image"],
        thumbnail: json["Dish_thumbnail"],
        rate: json["Dish_rate"],
        itemCartIndex:
            json["item_cart_index"] == null ? null : json["item_cart_index"],
        Description: json["Dish_description"],
      );

  Map<String, dynamic> toMap() => {
        "Dish_id": dish_id,
        "Dish_name": dish_name,
        "Dish_image": image,
        "Dish_thumbnail": thumbnail,
        "Dish_rate": rate,
        "item_cart_index": itemCartIndex,
      };
}
