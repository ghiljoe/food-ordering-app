import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordering_menu_app/controllers/location_controller.dart';
import 'package:ordering_menu_app/controllers/menu_controller.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Cart extends StatelessWidget {
  final MenuController menuController = Get.put(MenuController());
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Cart',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.pinkAccent,
                                    ),
                                    Text(
                                      'Deliver to',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: FutureBuilder(
                                    future:
                                        locationController.getCurrentAddress(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                      return GlowingProgressIndicator(
                                        child: Icon(Icons.location_on),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Orders',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey,
                                      ),
                                      child: GestureDetector(
                                        onTap: () => menuController.clearCart(),
                                        child: Text(
                                          'CLEAR',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Obx(() => menuController.cart.length > 0
                                    ? Column(
                                        children: [
                                          ...menuController.cart
                                              .map((item) => Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            item.itemCount
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              item.name,
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Text(
                                                            '₱ ${menuController.getTotalPriceWithTax(item).toStringAsFixed(2)}',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Divider(
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  )),
                                          SizedBox(
                                            height: 70,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Subtotal',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '₱ ${menuController.subTotalAmount().toStringAsFixed(2)}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
//                                          Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.spaceBetween,
//                                            children: [
//                                              Text(
//                                                'Total vat',
//                                                style: TextStyle(
//                                                    fontSize: 20,
//                                                    color: Colors.black,
//                                                    fontWeight:
//                                                        FontWeight.bold),
//                                              ),
//                                              Text(
//                                                '₱ ${menuController.totalVat().toStringAsFixed(2)}',
//                                                style: TextStyle(
//                                                    fontSize: 20,
//                                                    color: Colors.black,
//                                                    fontWeight:
//                                                        FontWeight.bold),
//                                              ),
//                                            ],
//                                          ),
//                                          SizedBox(
//                                            height: 30,
//                                          ),
                                          Obx(
                                            () => menuController
                                                    .isValidVoucher.isTrue
                                                ? Container(
                                                    width: double.infinity,
                                                    height: 70,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              menuController
                                                                  .voucher,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              '-10%',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () =>
                                                              menuController
                                                                  .removeVoucher(),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Remove voucher',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .pink,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                                : GestureDetector(
                                                    onTap: () =>
                                                        applyVoucherBottomSheet(
                                                            menuController),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.payment,
                                                          color: Colors.pink,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Apply Voucher',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.pink,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          )
                                        ],
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text(
                                          'No orders',
                                          style: TextStyle(),
                                        )),
                                      )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(() => menuController.cart.length > 0
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₱ ${menuController.totalAmount().toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () => menuController.placeOrder(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: double.infinity,
                                height: 60,
                                child: Center(
                                    child: Obx(
                                  () => menuController
                                          .isLoadingPlaceOrder.isTrue
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
                                          'Place Order',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                )),
                              ),
                            ),
                          ],
                        )),
                  ),
                )
              : Container())
        ],
      ),
    );
  }
}

void applyVoucherBottomSheet(MenuController menuController) {
  Get.bottomSheet(
    Stack(
      children: [
        Container(
          height: MediaQuery.of(Get.context).size.width / 1.3,
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  autocorrect: true,
                  controller: menuController.voucherTextField,
                  decoration: InputDecoration(
                    labelText: 'Voucher code',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Obx(() => menuController.revealInvalidMessage.isFalse
                  ? Container()
                  : Text(
                      'Invalid voucher code',
                      style: TextStyle(color: Colors.red),
                    )),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink,
                            elevation: 0,
                          ),
                          onPressed: () {
                            if (menuController.voucherTextField.text.isEmpty) {
                              return;
                            }
                            menuController.applyVoucher();

                            if (menuController.isValidVoucher.isTrue) {
                              Get.back();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              'Apply',
                              style: TextStyle(fontSize: 18),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: GestureDetector(
              onTap: () {
                menuController.closeVoucherBottomSheet();
                Get.back();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.close,
                    size: 35,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Apply Voucher',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ],
              )),
        )
      ],
    ),
    isDismissible: false,
  );
}
