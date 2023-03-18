// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:e_commerce_app/pages/checkout.dart';
import 'package:e_commerce_app/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductAndPrice extends StatelessWidget {
  const ProductAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return Row(children: [
      Stack(children: [
        Container(
          child: Text(
            "${classInstancee.selectedProduct.length}",
            style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Color.fromARGB(211, 164, 255, 193),
              shape: BoxShape.circle),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Checkout(),
              ),
            );
          },
          icon: Icon(Icons.add_shopping_cart),
        ),
      ]),
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text(
          "\$ ${classInstancee.price}",
          style: TextStyle(fontSize: 18),
        ),
      ),
    ]);
  }
}
