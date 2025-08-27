/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user/app/controller/find_location_controller.dart';
import 'package:user/app/util/theme.dart';

import '../controller/rive_controller.dart';

class FindLocationScreen extends StatefulWidget {
  const FindLocationScreen({super.key});

  @override
  State<FindLocationScreen> createState() => _FindLocationScreenState();
}

class _FindLocationScreenState extends State<FindLocationScreen> {
  final RiveMultiController _riveController = RiveMultiController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindLocationController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text('Find Location'.tr, style: ThemeProvider.titleStyle),
            actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.cancel_outlined, color: ThemeProvider.whiteColor))],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
             /* children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: ThemeProvider.greyColor.shade200, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: ThemeProvider.greyColor),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: value.searchbarText,
                            onChanged: (content) {
                              value.onSearchChanged(content);
                            },
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'Search location'.tr),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                value.getList.isNotEmpty
                    ? Container(
                        decoration: const BoxDecoration(color: ThemeProvider.whiteColor),
                        child: Column(
                          children: [
                            for (var item in value.getList)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: InkWell(
                                  onTap: () => value.getLatLngFromAddress(item.description.toString()),
                                  child: Row(
                                    children: [const Icon(Icons.search), const SizedBox(width: 10), Text(item.description!.length > 25 ? '${item.description!.substring(0, 25)}...' : item.description!)],
                                  ),
                                ),
                              )
                          ],
                        ),
                      )
                    : const SizedBox(height: 20,),
                value.getList.isEmpty
                    ? TextButton(
                        onPressed: () => value.getLocation(),
                        child: Text('Use My Current Location'.tr.toUpperCase(), style: const TextStyle(color: ThemeProvider.appColor, letterSpacing: 1.1)),
                      )
                    : const SizedBox(height: 20),
                SizedBox(height: value.getList.isEmpty ? 20 : 0),
                value.getList.isEmpty
                    ? const SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: SizedBox(
                          height: 180,
                          child: RiveAnimation.asset(
                              fit: BoxFit.cover,
                              'assets/rive/loc.riv'),
                        )
                        //GoogleMap(onMapCreated: value.onMapCreated, markers: value.markers, initialCameraPosition: CameraPosition(target: LatLng(value.myLat, value.myLng), zoom: 15)),
                      )
                    : const SizedBox(height: 20,),
                SizedBox(height: value.getList.isEmpty ? 20 : 0),
                value.isConfirmed == true
                    ?
               /* ElevatedButton(
                        onPressed: () => value.onConfirmLocation(),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ThemeProvider.whiteColor,
                          backgroundColor: ThemeProvider.appColor,
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Text('Confirm Location'.tr.toUpperCase(), style: const TextStyle(color: ThemeProvider.whiteColor, fontSize: 14, letterSpacing: 1.1)),
                      )*/
                GestureDetector(
                  onTap: () => value.onConfirmLocation(),
                  child:
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    child:
                    RiveAnimation.asset(
                      'assets/rive/cat_button.riv',
                      fit: BoxFit.cover,
                      onInit: (artboard) {
                        _riveController.init(
                          key: 'rive1',
                          artboard: artboard,
                          stateMachineName: 'State Machine 1',
                          inputNames: ['step', 'thunderGodMode'],
                        );
                        setState(() {});
                      },
                    ),
                  ),
                )


                    : const SizedBox(),
              ],*/
                children: [
                  // Barre de recherche
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: ThemeProvider.greyColor.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: ThemeProvider.greyColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: value.searchbarText,
                            onChanged: value.onSearchChanged,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search location'.tr,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Suggestions / résultats de recherche
                  if (value.getList.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        color: ThemeProvider.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.getList.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final item = value.getList[i];
                          return InkWell(
                            onTap: () => value.getLatLngFromAddress(item.description.toString()),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                              child: Row(
                                children: [
                                  const Icon(Icons.place, size: 18, color: ThemeProvider.appColor),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      item.description!.length > 40
                                          ? '${item.description!.substring(0, 40)}...'
                                          : item.description!,
                                      style: const TextStyle(fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 32),

                  // Bouton/suggestion GPS lorsque la liste est vide
                  if (value.getList.isEmpty) ...[
                    Center(
                      child: TextButton.icon(
                        onPressed: value.getLocation,
                        style: TextButton.styleFrom(
                          foregroundColor: ThemeProvider.appColor,
                          textStyle: const TextStyle(letterSpacing: 1.1),
                        ),
                        icon: const Icon(Icons.my_location),
                        label: Text('Use My Current Location'.tr.toUpperCase()),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Animation Rive de localisation, descendue plus bas, détachée de la barre de recherche
                    Center(
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: RiveAnimation.asset(
                          'assets/rive/loc.riv',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],

                  // Bouton animé de confirmation
                  if (value.isConfirmed)
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Center(
                        child: GestureDetector(
                          onTap: value.onConfirmLocation,
                          child: const SizedBox(
                            height: 196,
                            width: 240,
                            child: RiveAnimation.asset(
                              'assets/rive/cat_button.riv',
                              fit: BoxFit.cover,
                              animations: ['appeared wave L 2', 'appeared wave R 2'],
                              stateMachines: ['State Machine 1'],
                              /*onInit: (artboard) {
                                _riveController.init(
                                  key: 'rive1',
                                  artboard: artboard,
                                  stateMachineName: 'State Machine 1', animations: ['appeared wave L 2'], inputNames: []
                                );
                                setState(() {});
                              }*/
                            ),
                          ),
                        ),
                      ),
                    ),
                ]

            ),
          ),
        );
      },
    );
  }
}
