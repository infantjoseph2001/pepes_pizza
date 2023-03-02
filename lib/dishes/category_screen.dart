import 'package:flutter/material.dart';
import 'package:pepess_pizza/dishes/dishes_list.dart';

class Category extends StatefulWidget {
  final Dish obj;
  const Category(this.obj, {super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.obj.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              height: 200,
              width: 250,
              child: Image.network(
                widget.obj.image,
                fit: BoxFit.fill,
              )),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Categories",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.obj.Category,
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(
            height: 7,
          ),
          const Text(
            "Dishes",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              widget.obj.Dish,
              style: const TextStyle(fontSize: 17),
            ),
          )
        ],
      ),
    );
  }
}
