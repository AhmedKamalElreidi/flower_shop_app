// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:e_commerce_app/pages/details_screen.dart';
import 'package:e_commerce_app/provider/cart.dart';
import 'package:e_commerce_app/shared_widget/appbar.dart';
import 'package:e_commerce_app/shared_widget/colors.dart';
import 'package:e_commerce_app/pages/checkout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Item {
  String imgPath;
  double price;
  String location;
  String name;
  Item(
      {required this.name,
        required this.imgPath,
      required this.price,
      this.location = "Main Branch"});
}

class Home extends StatelessWidget {
  final List items = [
    Item(name: "Product1" ,imgPath: "assets/img/1.webp", price: 112.98, location: "Ahmed Branch"),
    Item(name: "Product2" ,imgPath: "assets/img/2.webp", price: 212.99),
    Item(name: "Product3" ,imgPath: "assets/img/3.webp", price: 312.99),
    Item(name: "Product4" ,imgPath: "assets/img/4.webp", price: 412.99),
    Item(name: "Product5" ,imgPath: "assets/img/5.webp", price: 512.99),
    Item(name: "Product6" ,imgPath: "assets/img/6.webp", price: 612.99),
    Item(name: "Product7" ,imgPath: "assets/img/7.webp", price: 712.99),
    Item(name: "Product8" ,imgPath: "assets/img/8.webp", price: 812.99),
  ];
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text("Ahmed kamal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 7, 7, 7),
                        )),
                    accountEmail: Text("Ahmed@yahoo.com",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 7, 7, 7),
                        )),
                    currentAccountPicture: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("assets/img/3.jpeg"),
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/test.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  ListTile(
                      title: Text("Home"),
                      leading: Icon(Icons.home),
                      onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => Home(),
                      ),
                    );
                      }),
                  ListTile(
                      title: Text("My products"),
                      leading: Icon(Icons.add_shopping_cart),
                      onTap: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Checkout(),
                      ),
                    );
                      }),
                  ListTile(
                      title: Text("About"),
                      leading: Icon(Icons.help_center),
                      onTap: () {}),
                  ListTile(
                      title: Text("Logout"),
                      leading: Icon(Icons.exit_to_app),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      }),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Text("Developed by Ahmed Kamal @ 2023")),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: appbarGreen,
          actions: [
           //Row of product and price
            ProductAndPrice()
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 22),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 33),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(product: items[index]),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Stack(children: [
                      Positioned(
                        top: -3,
                        bottom: -9,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.asset(items[index].imgPath)),
                      ),
                    ]),
                    footer: GridTileBar(
                      // backgroundColor: Color.fromARGB(66, 73, 127, 110),
                      trailing: IconButton(
                            color: Color.fromARGB(255, 62, 94, 70),
                            onPressed: () {
                              classInstancee.add(items[index]);
                            },
                            icon: Icon(Icons.add)),                 

                      leading: Text(items[index].price.toString()),

                      title: Text(
                        "",
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
