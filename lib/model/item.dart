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