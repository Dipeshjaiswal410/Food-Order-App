// ignore_for_file: public_member_api_docs, sort_constructors_first
class ItemModel {
  String itemName;
  int itemPrice;
  bool itemAvailability;
  String itemImage;
  String itemDescription;

  ItemModel({
    required this.itemName,
    required this.itemPrice,
    required this.itemAvailability,
    required this.itemImage,
    required this.itemDescription
  });
}

/* ignore: non_constant_identifier_names
List<ItemModel> Pizza = [
  ItemModel(
    itemName: "Chicken Pizza",
    itemPrice: 5,
    itemAvailability: true,
    itemImage:
        "https://bluebowlrecipes.com/wp-content/uploads/2019/05/barbecue-chicken-pizza-0917-683x1024.jpg",
  ),
  ItemModel(
      itemName: "Veg Pizza",
      itemPrice: 5,
      itemAvailability: true,
      itemImage:
          "https://cdn.loveandlemons.com/wp-content/uploads/2023/02/vegetarian-pizza-recipe-683x1024.jpg"),
  ItemModel(
      itemName: "Greek Pizza",
      itemPrice: 5,
      itemAvailability: true,
      itemImage:
          "https://www.cookingclassy.com/wp-content/uploads/2013/10/greek-pizza2+srgb..jpg"),
  ItemModel(
      itemName: "Chicago Pizza",
      itemPrice: 5,
      itemAvailability: true,
      itemImage:
          "https://www.simplyrecipes.com/thmb/11IogK6VchNV5yJmcFx8IVCzYpY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Chicago-Deep-Dish-Pizza-LEAD-1-b128003a85f74196b5f3668f7194d1af.jpg"),
  ItemModel(
      itemName: "New York Pizza",
      itemPrice: 5,
      itemAvailability: true,
      itemImage:
          "https://www.2foodtrippers.com/wp-content/uploads/2019/03/Slices-at-Marios-Pizzeria-in-the-Bronx-735x490.jpg.webp"),
];*/
