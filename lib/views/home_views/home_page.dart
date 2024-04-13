import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';
import 'package:food_ordering/views/cart%20view/cart_page.dart';
import 'package:food_ordering/views/category_views/category_model.dart';
import 'package:food_ordering/views/category_views/category_page.dart';
import 'package:food_ordering/views/category_views/category_provider.dart';
import 'package:food_ordering/views/home_views/drawer_view.dart';
import 'package:food_ordering/views/item_views/item_detail_page.dart';
import 'package:food_ordering/views/item_views/item_model.dart';
import 'package:food_ordering/views/notification%20view/notification_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final catProvider = Provider.of<CategoryProvider>(context, listen: false);
    catProvider.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final catProvider = Provider.of<CategoryProvider>(context, listen: false);
    print("Build.......*****");
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 238, 238),
      drawer: const DrawerScreen(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: false,
              pinned: true,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text("Our Menu",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.black)),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                    },
                    icon: const Icon(
                      Icons.trolley,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationPage()));
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    )),
              ],
            ),
          ];
        },
        body: Column(
          children: [
            SizedBox(
                width: size.width,
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Categories:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                )),
            // Category Row
            SizedBox(
              height: size.height / 6,
              child: catProvider.categories.isEmpty
                  ? Center(
                      child: IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.refresh,
                            size: 50,
                          )),
                    )
                  : ListView.builder(
                      itemCount: catProvider
                          .categories.length, //categoryItemList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, index) {
                        CategoryModel categoryData =
                            catProvider.categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 3, right: 3),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryScreen(
                                            categoriName:
                                                categoryData.categoryName,
                                          )));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.white,
                              elevation: 3,
                              shadowColor: appColor,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      //height: size.height / 6,
                                      width: size.width / 3.2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(),
                                        child: Center(
                                          child: Image.network(
                                              fit: BoxFit.fill,
                                              categoryData.categoryImage),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Center(
                                      child: Text(
                                        categoryData
                                            .categoryName, //categoryItemList[index].categoryName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(
                width: size.width,
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Top Items:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                )),

            //Grid view of items
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("TopItems")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No data found"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // Extracting data from the snapshot
                  var documents = snapshot.data!.docs;
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // Adjust the number of columns as needed
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0),
                      itemCount: documents.length,
                      shrinkWrap: true, // your item count here,
                      itemBuilder: (context, index) {
                        // Create an ItemModel from Firestore data
                        ItemModel item = ItemModel(
                          itemName: documents[index]['itemName'],
                          itemPrice: documents[index]['itemPrice'],
                          itemAvailability: documents[index]
                              ['itemAvailability'],
                          itemImage: documents[index]['itemImage'],
                          itemDescription: documents[index]['itemDescription'],
                        );
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemDetailScreen(
                                          itemsDetails: ItemModel(
                                              itemName: item.itemName,
                                              itemPrice: item.itemPrice,
                                              itemAvailability:
                                                  item.itemAvailability,
                                              itemImage: item.itemImage,
                                              itemDescription:
                                                  item.itemDescription),
                                        )));
                          },
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Food item image
                                Container(
                                  height: 120.0, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        item.itemImage,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Food item name
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Center(
                                    child: Text(
                                      item.itemName, // Replace with actual item name
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // Food item price
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Center(
                                    child: Text(
                                      "\$${item.itemPrice}", // Replace with actual item price
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color:
                                            appColor, // Adjust color as needed
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),

            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  //Extracting animation part
}








/*import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';
import 'package:food_ordering/views/home_views/animation_part/animation_images.dart';
import 'package:food_ordering/views/home_views/animation_part/animation_provider.dart';
import 'package:food_ordering/views/home_views/category_page.dart';
import 'package:food_ordering/views/home_views/item_detail_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AnimationStateProvider animationState;

  @override
  void initState() {
    super.initState();
    animationState =
        Provider.of<AnimationStateProvider>(context, listen: false);
    animationState.startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("Build.......*****");
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: const Text(
          "Our Menu",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        child: Column(
          children: [
            SizedBox(
                width: size.width,
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Categories:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                )),
            // Category Row
            SizedBox(
              height: size.height / 6,
              //width: 200,
              //color: appColor,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CategoryScreen(
                                    categoriName: "Pizza")));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        elevation: 3,
                        shadowColor: appColor,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                //height: size.height / 6,
                                width: size.width / 3.2,
                                child: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Center(
                                    child: Image.network(
                                        fit: BoxFit.fill,
                                        "https://www.indianhealthyrecipes.com/wp-content/uploads/2015/10/pizza-recipe-1.jpg"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Center(
                                child: Text(
                                  "Pizza",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height / 200,
            ),

            // Animating Portion...
            Container(
              color: const Color.fromARGB(255, 237, 198, 139),
              //color: const Color.fromARGB(255, 216, 215, 215),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Selector<AnimationStateProvider, double>(
                  selector: (_, animationState) => animationState.offset,
                  builder: (_, offset, __) {
                    return Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 16),
                          transform:
                              Matrix4.translationValues(offset, 0.0, 0.0),
                          child: Row(
                            children: List.generate(
                              animationState.itemCount,
                              (index) => ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  color: Colors.blue,
                                  height: size.height / 14,
                                  width: size.width / 3,
                                  //width: animationState.itemWidth,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Image.network(
                                      animationImagesList[index],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            //Grid view of items
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 20,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ItemDetailScreen()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 1,
                      shadowColor: appColor,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              //height: size.height / 7,
                              child: ClipRRect(
                                child: Image.network(
                                  "https://www.foodandwine.com/thmb/pwFie7NRkq4SXMDJU6QKnUKlaoI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Ultimate-Veggie-Burgers-FT-Recipe-0821-5d7532c53a924a7298d2175cf1d4219f.jpg",
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            const Text(
                              "Pizza",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            const Text(
                              "Price: USD 5",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: appColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  //Extracting animation part
}
*/