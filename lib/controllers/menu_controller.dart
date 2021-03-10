import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ordering_menu_app/models/menu_category.dart';
import 'package:ordering_menu_app/models/menu_category_item.dart';
import 'package:ordering_menu_app/models/order.dart';
import 'package:ordering_menu_app/models/order_item.dart';
import 'package:ordering_menu_app/services/menu_services.dart';
import 'package:ordering_menu_app/views/order_summary_page.dart';
import 'package:ordering_menu_app/views/widgets/Toaster.dart';

class MenuController extends GetxController {
  List<MenuCategory> menuCategoryList = <MenuCategory>[].obs;
  List<OrderItem> orderItems = <OrderItem>[].obs;
  List<MenuCategoryItem> menuCategoryItemList = <MenuCategoryItem>[].obs;
  List<MenuCategoryItem> cart = <MenuCategoryItem>[].obs;
  Order order;
  final localStorage = GetStorage();
  final voucherTextField = TextEditingController();
  var isLoadingMenuList = false.obs;
  var isLoadingMenuItemList = false.obs;
  var isValidVoucher = false.obs;
  var revealInvalidMessage = false.obs;
  var isLoadingPlaceOrder = false.obs;
  var counter = 0.obs;
  String voucher = 'GO2018';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMenuCategoryList();
  }

  void getMenuCategoryList() async {
    try {
      isLoadingMenuList(true);
      var menuCategoryData = await MenuServices.getMenuCategories();
      if (menuCategoryData.length > 0) {
        menuCategoryList = menuCategoryData;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingMenuList(false);
    }
  }

  Future getMenuCategoryItem(int menuCategoryId) async {
    try {
      isLoadingMenuItemList(true);
      var menuCategoryItemData =
          await MenuServices.getMenuCategoryItems(menuCategoryId);
      if (menuCategoryItemData.length > 0) {
        menuCategoryItemList = menuCategoryItemData;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingMenuItemList(false);
    }
    return menuCategoryItemList;
  }

  void addQuantity() {
    counter++;
  }

  void deductQuantity() {
    if (counter.value == 0) {
      return;
    } else {
      counter--;
    }
  }

  void resetQuantity() {
    counter(0);
  }

  void addToCart(MenuCategoryItem menuCategoryItem, int itemCount) {
    if (cart.contains(menuCategoryItem)) {
      menuCategoryItem.itemCount += itemCount;
      cart.removeWhere((element) => element.id == menuCategoryItem.id);
      cart.add(menuCategoryItem);
    } else {
      menuCategoryItem.itemCount = itemCount;
      cart.add(menuCategoryItem);
    }
  }

  int totalItemCartCount() =>
      cart.fold(0, (prevValue, menuItem) => prevValue + menuItem.itemCount);

  double totalAmount() {
    var tempTotal = [];
    var tempTotalAmount = 0.0;
    var deduction = 0.0;
    var originalPrice;
    var vat;

    cart.forEach((menuItem) {
      originalPrice = menuItem.itemCount * double.parse(menuItem.price);
      vat = originalPrice * menuItem.tax;
      tempTotal.add(originalPrice + vat);
    });

    tempTotalAmount =
        tempTotal.fold(0, (prevValue, menuItem) => prevValue + menuItem);

    if (isValidVoucher.isTrue) {
      deduction = tempTotalAmount * 0.10;
      tempTotalAmount -= deduction;
    }
    return tempTotalAmount.roundToDouble();
  }

  double subTotalAmount() {
    var tempTotal = [];
    var originalPrice;
    var vat;

    cart.forEach((menuItem) {
      originalPrice = menuItem.itemCount * double.parse(menuItem.price);
      vat = originalPrice * menuItem.tax;
//      tempTotal.add(originalPrice);

      tempTotal.add(originalPrice.round() + vat.round());
    });

    return tempTotal.fold(0.0, (prevValue, menuItem) => prevValue + menuItem);
  }

  double totalVat() {
    var tempTotal = [];
    var originalPrice;
    var vat;

    cart.forEach((menuItem) {
      originalPrice = menuItem.itemCount * double.parse(menuItem.price);
      vat = originalPrice * menuItem.tax;
      tempTotal.add(vat.round());
    });

    return tempTotal.fold(0.0, (prevValue, menuItem) => prevValue + menuItem);
  }

  double getTotalPriceWithTax(MenuCategoryItem menuCategoryItem) {
    var originalPrice = double.parse(menuCategoryItem.price) *
        (menuCategoryItem.itemCount != null ? menuCategoryItem.itemCount : 1);
    var vat = originalPrice * menuCategoryItem.tax;
//    return originalPrice;
    return originalPrice.roundToDouble() + vat.roundToDouble();
  }

  double getTotalPriceWithTaxOrderSummary(OrderItem orderItem) {
    var originalPrice = orderItem.totalPrice;
    var vat = originalPrice * orderItem.tax;

//    return originalPrice;
    return originalPrice.roundToDouble() + vat.roundToDouble();
  }

  void clearCart() {
    isValidVoucher(false);
    cart.clear();
  }

  void applyVoucher() {
    if (voucherTextField.text == voucher) {
      isValidVoucher(true);
      voucherTextField.text = '';
      revealInvalidMessage(false);
    } else {
      isValidVoucher(false);
      revealInvalidMessage(true);
    }
  }

  void removeVoucher() {
    isValidVoucher(false);
  }

  void closeVoucherBottomSheet() {
    voucherTextField.text = '';
    revealInvalidMessage(false);
  }

//  userId, totalAmount, itemCount, menuCategoryItemId
  void placeOrder() async {
    Map data = {
      "userId": localStorage.read('userId'),
      "totalAmount": totalAmount(),
      "items": cart
    };
    try {
      isLoadingPlaceOrder(true);
      var orderResponse = await MenuServices.saveOrder(data);
      if (orderResponse != null) {
        order = orderResponse;
        getOrderSummary(orderResponse.id);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingPlaceOrder(false);
    }
  }

  void getOrderSummary(int orderId) async {
    var orderResponse = await MenuServices.getOrderItems(orderId);
    if (orderResponse != null) {
      orderItems = orderResponse;
      cart.clear();
      Get.off(() => OrderSummaryPage());
    } else {
      Toaster.normal('Something went wrong.');
    }
  }
}
