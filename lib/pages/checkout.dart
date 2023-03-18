// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:e_commerce_app/provider/cart.dart';
import 'package:e_commerce_app/shared_widget/appbar.dart';
import 'package:e_commerce_app/shared_widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout Screen"),
        backgroundColor: appbarGreen,
        actions: [ProductAndPrice()],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 550,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: classInstancee.selectedProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(classInstancee.selectedProduct[index].name),
                        subtitle: Text(
                            "\$ ${classInstancee.selectedProduct[index].price} - ${classInstancee.selectedProduct[index].location}"),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              classInstancee.selectedProduct[index].imgPath),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              classInstancee.delete(classInstancee.selectedProduct[index]);
                            },
                            icon: Icon(Icons.remove)),
                      ),
                    );
                  }),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Pay \$ ${classInstancee.price}",
              style: TextStyle(fontSize: 19),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(bTNpink),
              padding: MaterialStateProperty.all(EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
          ),
        ],
      ),
    );
  }
}
