import 'package:e_commerce_app/model/item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier  {
 List selectedProduct =[

 ];
 double price=0;
 add(Item product){
  selectedProduct.add(product);
  price+=product.price.round();
// شبة ال set state
  notifyListeners();
 }
  delete(Item product){
    selectedProduct.remove(product);
    price-=product.price.round();
      notifyListeners();

  }

}