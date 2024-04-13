// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  String categoryName;
  String categoryImage;
  CategoryModel({
    required this.categoryName,
    required this.categoryImage,
  });
}

List<CategoryModel> categoryItemList = [
  CategoryModel(
      categoryName: "MoMo",
      categoryImage:
          "https://img.etimg.com/thumb/msid-70813564,width-650,height-488,imgsize-348620,resizemode-75/momos.jpg"),
  CategoryModel(
      categoryName: "Pizza",
      categoryImage:
          "https://www.indianhealthyrecipes.com/wp-content/uploads/2015/10/pizza-recipe-1.jpg"),
  CategoryModel(
      categoryName: "Burger",
      categoryImage:
          "https://www.foodandwine.com/thmb/pwFie7NRkq4SXMDJU6QKnUKlaoI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Ultimate-Veggie-Burgers-FT-Recipe-0821-5d7532c53a924a7298d2175cf1d4219f.jpg"),
  CategoryModel(
      categoryName: "Sandwich",
      categoryImage:
          "https://t3.ftcdn.net/jpg/01/11/28/82/240_F_111288255_yYufRCRFaLsxVIlaAQMWYMTJD1R4Dy02.jpg"),
  CategoryModel(
      categoryName: "Chicken",
      categoryImage:
          "https://www.allrecipes.com/thmb/0u4sQA9vAbrdkviiVx5avYNq5f8=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/8805-CrispyFriedChicken-mfs-3x2-072-d55b8406d4ae45709fcdeb58a04143c2.jpg"),
  CategoryModel(
      categoryName: "Biryani",
      categoryImage:
          "https://www.foodandwine.com/thmb/4-pwcfnyVuc1yin4H4O0aeYYmqs=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Chicken-Biryani-FT-RECIPE0823-9d51c6e665ec4c9daa45162841e2f034.jpg"),
];
