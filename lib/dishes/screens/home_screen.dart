import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../dishes_list.dart';

class Dishpage extends StatefulWidget {
  @override
  State<Dishpage> createState() => _DishpageState();
}

class _DishpageState extends State<Dishpage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Dishes",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(
              "https://pepespizza-portal.azurewebsites.net//Images/Dish/",
              height: screenHeight * 0.25,
              width: screenWidth * 0.9,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "By Category",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 60,
                  width: 600,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: false,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 60,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "pizza",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Popular",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: 600,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: DishList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Category(DishList[index])));
                        },
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 150,
                                height: 150,
                                child: Image.network(
                                  DishList[index].image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Text(
                              DishList[index].name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Exploer",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                width: screenWidth,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: DishList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Category(Dishlist[index])));
                      },
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Image.network(
                              DishList[index].image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              DishList[index].name,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      child: Divider(
                        thickness: 1,
                        endIndent: 2,
                        indent: 1,
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "May be interested in",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: ListView.custom(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Category(DishList[index])));
                        },
                        child: Text(
                          DishList[index].name,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                      );
                    },
                    childCount: DishList.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
