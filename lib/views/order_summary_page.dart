import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordering_menu_app/controllers/menu_controller.dart';
import 'package:ordering_menu_app/views/menu_category_list_page.dart';
import 'package:progress_indicators/progress_indicators.dart';

class OrderSummaryPage extends StatelessWidget {
  final MenuController menuController = Get.put(MenuController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Order Summary',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            menuController.isValidVoucher(false);
            Get.to(() => MenuCategoryListPage());
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Obx(
                    () => menuController.isLoadingGetOrderSummary.isTrue
                        ? Center(
                            child: GlowingProgressIndicator(
                              child: Icon(
                                Icons.fastfood,
                                size: 100,
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '#${menuController.order.id}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              menuController.orderItems.length > 0
                                  ? Column(
                                      children: [
                                        ...menuController.orderItems
                                            .map((orderItem) => Column(
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
                                                          orderItem.quantity
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
                                                            orderItem.name,
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Text(
                                                          '₱ ${orderItem.totalPrice}',
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
                                          height: 50,
                                        ),
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
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'voucher',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.pink,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ))
                                              : Container(),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total Amount',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '₱ ${menuController.order.totalAmount.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                        'No orders',
                                      )),
                                    ),
                              SizedBox(
                                height: 70,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
