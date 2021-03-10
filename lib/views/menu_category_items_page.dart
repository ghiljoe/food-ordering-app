import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordering_menu_app/controllers/menu_controller.dart';
import 'package:ordering_menu_app/models/menu_category.dart';
import 'package:ordering_menu_app/models/menu_category_item.dart';
import 'package:ordering_menu_app/views/cart.dart';
import 'package:progress_indicators/progress_indicators.dart';

class MenuCategoryItemsPage extends StatelessWidget {
  final MenuCategory menuCategory;
  MenuCategoryItemsPage({Key key, this.menuCategory}) : super(key: key);

  final MenuController menuController = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.pink),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(menuCategory.name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      menuCategory.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  FutureBuilder(
                    future: menuController.getMenuCategoryItem(menuCategory.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              MenuCategoryItem menuCategoryItem =
                                  snapshot.data[index];
                              return GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      addToCartBottomSheet(
                                          menuCategoryItem, menuController);
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: 110,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        menuCategoryItem.image),
                                                    fit: BoxFit.fitHeight,
                                                  ))),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    menuCategoryItem.name ?? '',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      '₱ ${menuController.getTotalPriceWithTax(menuCategoryItem).toStringAsFixed(2) ?? '0.00'}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Center(
                        child: GlowingProgressIndicator(
                          child: Icon(
                            Icons.fastfood,
                            size: 100,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Obx(() => menuController.cart.length > 0
                ? Positioned(
                    bottom: -5,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Get.to(() => Cart()),
                      child: Container(
                        height: 100,
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: double.infinity,
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Obx(
                                    () => Text(
                                      menuController
                                          .totalItemCartCount()
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    'View Cart',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Obx(
                                    () => Text(
                                      '₱ ${menuController.subTotalAmount().toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  )
                : Container())
          ],
        ),
      ),
    );
  }
}

void addToCartBottomSheet(
    MenuCategoryItem menuCategoryItem, MenuController menuController) {
  Get.bottomSheet(
    Stack(
      children: [
        Container(
          height: MediaQuery.of(Get.context).size.width,
          color: Colors.white,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  menuCategoryItem.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      menuCategoryItem.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Text(
                        '₱ ${menuController.getTotalPriceWithTax(menuCategoryItem).toStringAsFixed(2) ?? '0.00'}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                            child: Obx(
                          () => Material(
                            color: menuController.counter.value == 0
                                ? Colors.grey
                                : Colors.pink, // button color
                            child: InkWell(
                              child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  )),
                              onTap: () => menuController.deductQuantity(),
                            ),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Obx(() {
                            return Text(menuController.counter.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600));
                          }),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.pink, // button color
                            child: InkWell(
                              child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(Icons.add, color: Colors.white)),
                              onTap: () => menuController.addQuantity(),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Obx(
                      () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: menuController.counter.value == 0
                                ? Colors.grey
                                : Colors.pink,
                            elevation: 0,
                          ),
                          onPressed: () {
                            if (menuController.counter.value == 0) {
                              return;
                            } else {
                              menuController.addToCart(menuCategoryItem,
                                  menuController.counter.value);
                              menuController.resetQuantity();
                              Get.back();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              'Add to cart',
                              style: TextStyle(fontSize: 18),
                            ),
                          )),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: GestureDetector(
            onTap: () {
              menuController.resetQuantity();
              Get.back();
            },
            child: Icon(
              Icons.backspace,
              size: 35,
            ),
          ),
        )
      ],
    ),
    isDismissible: false,
  );
}
