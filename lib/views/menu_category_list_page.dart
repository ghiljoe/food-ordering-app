import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordering_menu_app/controllers/login_controller.dart';
import 'package:ordering_menu_app/controllers/menu_controller.dart';
import 'package:ordering_menu_app/models/menu_category.dart';
import 'package:ordering_menu_app/views/menu_category_items_page.dart';

class MenuCategoryListPage extends StatelessWidget {
  final MenuController menuController = Get.put(MenuController());
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Obx(
                        () => Text(
                          '${loginController.initials}',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Text('${loginController.fullName}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () => Get.back(),
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () => loginController.logout(),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.pink),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Categories',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Obx(
              () => menuController.isLoadingMenuList.isTrue
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: menuController.menuCategoryList?.length,
                      itemBuilder: (context, index) {
                        MenuCategory menuCategory =
                            menuController.menuCategoryList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => MenuCategoryItemsPage(
                                    menuCategory: menuCategory,
                                  ));
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: Image.network(
                                      menuCategory.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      menuCategory.name,
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
