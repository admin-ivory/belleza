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

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
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
          body: value.apiCalled == false
              ? SkeletonListView()
              : value.productsList.isNotEmpty
              ? SingleChildScrollView( // Ajout de SingleChildScrollView ici
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // Désactiver le défilement du GridView
                shrinkWrap: true, // Permet au GridView de prendre seulement l'espace nécessaire
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Nombre de colonnes
                  childAspectRatio: 0.8, // Ratio de largeur/hauteur
                  crossAxisSpacing: 10, // Espacement horizontal
                  mainAxisSpacing: 10, // Espacement vertical
                ),
                itemCount: value.productsList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => value.onCategoryExpand(value.productsList[index].id.toString()),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeProvider.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // décalage de l'ombre
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: '${Environments.apiBaseURL}api/storage/images/${value.productsList[index].cover.toString()}',
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset("assets/images/placeholder.jpeg", fit: BoxFit.cover),
                              errorWidget: (context, url, error) => Image.asset('assets/images/notfound.png', fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ThemeProvider.blackColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    value.productsList[index].name.toString(),
                                    style: const TextStyle(color: ThemeProvider.whiteColor, fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    value.selectedCategory == value.productsList[index].id.toString()
                                        ? Icons.keyboard_arrow_down
                                        : Icons.keyboard_arrow_up,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (value.selectedCategory == value.productsList[index].id.toString())
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: List.generate(
                                  value.productsList[index].subCates!.length,
                                      (subIndex) => Container(
                                    decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(color: ThemeProvider.greyColor)),
                                    ),
                                    child: ListTile(
                                      onTap: () => value.onProducts(value.productsList[index].id as int, value.productsList[index].subCates![subIndex].id as int),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                      title: Text(value.productsList[index].subCates![subIndex].name.toString()),
                                    ),
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
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              SizedBox(height: 80, width: 80, child: Image.asset("assets/images/no-data.png", fit: BoxFit.cover)),
              const SizedBox(height: 30),
              Center(child: Text('No Data Found!'.tr, style: const TextStyle(fontFamily: 'bold'))),
            ],
          ),
        );
      },
    );
  }
}