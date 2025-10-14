/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_hero_transform/local_hero_transform.dart';
import 'package:rive/rive.dart' as rive;
import 'package:user/app/controller/categories_controller.dart';
import 'package:user/app/controller/product_cart_controller.dart';
import 'package:user/app/env.dart';
import 'package:user/app/util/theme.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>  with SingleTickerProviderStateMixin {


  late final TabController _tabcatcontroller;
  @override
  void initState() {
    super.initState();
      _tabcatcontroller = TabController(length: 2, vsync: this);  // longueur selon ton usage
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabcatcontroller,
              tabs: const [
                Tab(icon: Icon(Icons.grid_view), text: 'Grid'),
                Tab(icon: Icon(Icons.list), text: 'List'),
              ],

            ),
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text('Categories'.tr, style: ThemeProvider.titleStyle),
          ),
          bottomNavigationBar: Get.find<ProductCartController>().savedInCart.isNotEmpty
              ? SizedBox(
            height: 50,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () => value.onCart(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(color: ThemeProvider.appColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value.currencySide == 'left'
                                ? '${Get.find<ProductCartController>().savedInCart.length} ${'Items'.tr} ${value.currencySymbol} ${Get.find<ProductCartController>().totalPrice}'
                                : ' ${Get.find<ProductCartController>().savedInCart.length} ${'Items'.tr} ${Get.find<ProductCartController>().totalPrice}${value.currencySymbol}',
                            style: const TextStyle(color: ThemeProvider.whiteColor),
                          ),
                          Text('Payments'.tr, style: const TextStyle(color: ThemeProvider.whiteColor)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
              : const SizedBox(),

          body: TabBarView(
              controller: _tabcatcontroller,
              children: [ value.apiCalled == false
              ? SkeletonListView()
              : value.productsList.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: LocalHeroViews(
              tabController: _tabcatcontroller, // Assure-toi d’avoir ce controller dans ton State
              textDirection: TextDirection.ltr, // Ou variable en fonction de la langue
              itemCount: value.productsList.length,
              itemsModel: (index) {
                final item = value.productsList[index];
                return ItemsModel(
                  name: Text(item.name ?? '', style: const TextStyle(color: ThemeProvider.greyColor)),
                  title: Text(item.name ?? ''),
                  subTitle: const Text(''), // Ajoute ici un sous-titre si pertinent
                  favoriteIconButton: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // Logique favoris si besoin
                    },
                  ),
                  subTitleIcon: const Icon(Icons.keyboard_arrow_right, size: 18),
                  image: DecorationImage(
                    image: NetworkImage('${Environments.apiBaseURL}/storage/images/${item.cover ?? ''}'),
                    fit: BoxFit.cover,
                  ),
                );
              }, onPressedCard: (int index) {  },

            ),
          )
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80, width: 80, child: rive.RiveAnimation.asset("assets/rive/empty.riv", fit: BoxFit.cover)),
                const SizedBox(height: 30),
                Center(child: Text('No Data Found!'.tr, style: const TextStyle(fontFamily: 'bold'))),
              ],
            ),
          ),])

        );
      },
    );
  }
}