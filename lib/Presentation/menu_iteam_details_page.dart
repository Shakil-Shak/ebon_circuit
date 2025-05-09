// ignore_for_file: must_be_immutable

import 'package:ebon_circuit/color.dart';
import 'package:ebon_circuit/modelsPages/menu_model.dart';
import 'package:ebon_circuit/customWidgets/custom_backend.dart';
import 'package:ebon_circuit/customWidgets/custom_text.dart';
import 'package:ebon_circuit/customWidgets/custom_widgets.dart';
import 'package:ebon_circuit/modelsPages/iteam_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MenuIteamDetailsPage extends StatefulWidget {
  MenuIteamModel iteamModel;
  List<IteamModel>? iteamList;
  MenuIteamDetailsPage(
      {super.key, required this.iteamModel, required this.iteamList});
  @override
  _MenuIteamDetailsPage createState() => _MenuIteamDetailsPage();
}

class _MenuIteamDetailsPage extends State<MenuIteamDetailsPage> {
  int quantity = 1;
  late double totalPrice;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.iteamModel.price ??= 0.0;
    totalPrice = widget.iteamModel.price ?? 0.0;
    priviewImage = widget.iteamModel.iteamImagePath.toString();
  }

  late String priviewImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor,
                    blurRadius: 3,
                  ),
                ],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25)),
              ),
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25)),
                child: PhotoView(
                  imageProvider: CachedNetworkImageProvider(
                      priviewImage), // Use priviewImage
                  backgroundDecoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  minScale: PhotoViewComputedScale.contained * 1,
                  maxScale: PhotoViewComputedScale.covered * 2.5,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              height: 80, // Height of each image container
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    (widget.iteamModel.additionalImages?.length ?? 0) + 1,
                itemBuilder: (context, index) {
                  String imageUrl;
                  if (index == 0) {
                    imageUrl = widget.iteamModel.iteamImagePath ?? '';
                  } else {
                    imageUrl = widget.iteamModel.additionalImages![index - 1];
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          priviewImage =
                              imageUrl; // Update priviewImage when clicked
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 3,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 32),
                    child: Column(children: [
                      Row(
                        children: [
                          customText("Title", size: 21),
                        ],
                      ),
                      Row(
                        children: [
                          RatingStar(rating: 4, starColor: Colors.red),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText("4 Star Rattings", size: 11),
                          customText("${widget.iteamModel.price} BDT",
                              size: 24, fontWeigth: FontWeight.bold),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          customText("/ per Portion"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          customText("Description",
                              fontWeigth: FontWeight.bold),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: customText(
                                widget.iteamModel.description.toString(),
                                size: 12,
                                softWrap: true),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: customText("Number of Portion",
                                  fontWeigth: FontWeight.bold, softWrap: true)),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    CustomWidgets.snackBarCustom(context,
                                        massage:
                                            "You can increase or decrease from here. Add and go to Cart");
                                  },
                                  child: const CircleAvatar(
                                      backgroundColor: primaryColor,
                                      child: Icon(
                                        Icons.remove,
                                        color: primaryColor,
                                      )),
                                )),
                                Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                width: 1, color: primaryColor)),
                                        child: Center(
                                            child: customText(
                                                quantity.toString(),
                                                color: primaryColor)))),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      CustomWidgets.snackBarCustom(context,
                                          massage:
                                              "You can increase or decrease from here. Add and go to Cart");
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: primaryColor,
                                      child: Icon(
                                        Icons.add,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText("Total Price", size: 18, softWrap: true),
                          customText(
                              "${widget.iteamModel.price ?? 0.0 * quantity} BDT",
                              size: 28,
                              fontWeigth: FontWeight.bold),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomWidgets.iconButtonCustom(
                            imageIconpath: "",
                            icon: const Icon(
                              Icons.shopping_cart_checkout_outlined,
                              color: primaryColor,
                            ),
                            hintText: "Add to Cart",
                            onPressedButton: () async {
                              widget.iteamModel.price ??= 0.0;
                              widget.iteamList ??= [];
                              CustomWidgets.progressBarCustom(context);

                              for (int i = 0;
                                  i < widget.iteamList!.length;
                                  i++) {
                                if (widget.iteamList![i].iteam!.iteamName ==
                                    widget.iteamModel.iteamName) {
                                  CustomWidgets.snackBarCustom(context,
                                      massage:
                                          "This iteam already have in cart");

                                  Navigator.pop(context);

                                  return;
                                }
                              }

                              print("working");
                              widget.iteamList = [];
                              widget.iteamList!.add(IteamModel(
                                  iteam: widget.iteamModel,
                                  quantity: quantity));

                              await CustomBackEnd.uploadCartDataToFirebase(
                                      widget.iteamList!)
                                  .then(
                                (value) {
                                  Navigator.pop(context);

                                  CustomWidgets.snackBarCustom(context,
                                      massage: "iteam added to cart");
                                },
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
