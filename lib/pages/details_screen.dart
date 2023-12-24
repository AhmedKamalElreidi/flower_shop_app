// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:e_commerce_app/model/item.dart';
import 'package:e_commerce_app/shared_widget/colors.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.product});
  final Item product;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details screen"),
        backgroundColor: appbarGreen,
        actions: [
          Row(children: [
            Stack(children: [
              Container(
                child: Text(
                  "0",
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color.fromARGB(211, 164, 255, 193),
                    shape: BoxShape.circle),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_shopping_cart),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                "\$ 0",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ]),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.product.imgPath),
            SizedBox(
              height: 11,
            ),
            Text(
              "\$ ${widget.product.price}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 5,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    "New",
                    style: TextStyle(fontSize: 13),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color.fromARGB(255, 255, 129, 129),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Color.fromARGB(255, 255, 191, 0),
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Color.fromARGB(255, 255, 191, 0),
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Color.fromARGB(255, 255, 191, 0),
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Color.fromARGB(255, 255, 191, 0),
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: Color.fromARGB(255, 255, 191, 0),
                    ),
                  ],
                ),
                SizedBox(
                  width: 48,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.edit_location,
                      size: 24,
                      color: Color.fromARGB(168, 3, 65, 27),
                    ),
                    Text(widget.product.location,
                        style: TextStyle(fontSize: 17)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Details : ",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers produce gametophytes, which in flowering plants consist of a few haploid cells which produce gametes A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers produce gametophytes, which in flowering plants consist of a few haploid cells which produce gametes ",
              style: TextStyle(fontSize: 18),
              maxLines: isShowMore ? 3 : null,
              overflow: TextOverflow.fade,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isShowMore ? isShowMore = false : isShowMore = true;
                  //isShowMore=!isShowMore;
                });
              },
              child: Text(
                isShowMore ? "Show More " : "Show Less",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
