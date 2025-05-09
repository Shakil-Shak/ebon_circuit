import 'package:ebon_circuit/color.dart';
import 'package:ebon_circuit/customWidgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ebon_circuit/modelsPages/menu_model.dart';
import '../customWidgets/custom_widgets.dart';

// ignore: must_be_immutable
class IteamCustomization extends StatefulWidget {
  MenuModelFirebaseSetData? myMenuIteamList;
  MenuIteamModel iteam;
  String catagoryName;

  IteamCustomization(
      {super.key,
      required this.myMenuIteamList,
      required this.iteam,
      required this.catagoryName});

  @override
  _IteamCustomizationState createState() => _IteamCustomizationState();
}

class _IteamCustomizationState extends State<IteamCustomization> {
  TextEditingController catagoryController = TextEditingController();
  TextEditingController iteamNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catagoryController.text = widget.catagoryName;
    iteamNameController.text = widget.iteam.iteamName.toString();
    descriptionController.text = widget.iteam.description.toString();
    priceController.text = widget.iteam.price.toString();
    discountController.text = widget.iteam.discount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Iteam'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: customText("Catagory Name"),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomWidgets.textFormFieldCustom(
                    enabled: false, controller: catagoryController),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: customText("Iteam Name"),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomWidgets.textFormFieldCustom(
                    controller: iteamNameController),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: customText("Price"),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomWidgets.textFormFieldCustom(controller: priceController),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: customText("Discount"),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomWidgets.textFormFieldCustom(
                    controller: discountController),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: customText("Description"),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    maxLines: 3,
                    minLines: 3,
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: primaryColor),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: primaryColor),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: primaryColor),
                          borderRadius: BorderRadius.circular(25),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomWidgets.elevatedButtonCustom(
                    hintText: "Update",
                    onPressedButton: () {
                      if (descriptionController.text.isEmpty) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: customText(
                                    "Do you update item description:"),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child:
                                            CustomWidgets.elevatedButtonCustom(
                                                hintText: "Yes",
                                                onPressedButton: () {
                                                  if (catagoryController
                                                              .text.length >
                                                          2 &&
                                                      iteamNameController
                                                              .text.length >
                                                          2) {
                                                    editCatagoryToMenuIteamListAndFirebase(
                                                        price: priceController
                                                            .text,
                                                        discription:
                                                            discountController
                                                                .text,
                                                        description:
                                                            descriptionController
                                                                .text
                                                                .toString(),
                                                        iteamName:
                                                            iteamNameController
                                                                .text,
                                                        catagory:
                                                            catagoryController
                                                                .text,
                                                        imagePath: widget.iteam
                                                            .iteamImagePath
                                                            .toString());
                                                  } else {
                                                    CustomWidgets.snackBarCustom(
                                                        context,
                                                        massage:
                                                            "itam name can't be emply");
                                                  }

                                                  Navigator.pop(context);
                                                }),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child:
                                            CustomWidgets.elevatedButtonCustom(
                                          hintText: "No",
                                          onPressedButton: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            });
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editCatagoryToMenuIteamListAndFirebase(
      {required String iteamName,
      required String catagory,
      required String description,
      required String discription,
      required String price,
      required String imagePath}) {
    for (int i = 0; i < widget.myMenuIteamList!.menuIteamList!.length; i++) {
      if (widget.myMenuIteamList!.menuIteamList![i].menuName == catagory) {
        for (int j = 0;
            j < widget.myMenuIteamList!.menuIteamList![i].iteams!.length;
            j++) {
          if (widget.myMenuIteamList!.menuIteamList![i].iteams![j].iteamName ==
              widget.iteam.iteamName) {
            widget.myMenuIteamList!.menuIteamList![i].iteams![j].iteamName =
                iteamName;
            widget.myMenuIteamList!.menuIteamList![i].iteams![j].description =
                description;
            widget.myMenuIteamList!.menuIteamList![i].iteams![j]
                .iteamImagePath = imagePath;

            try {
              double? iteamPrice = double.parse(price);
              widget.myMenuIteamList!.menuIteamList![i].iteams![j].price =
                  iteamPrice;
            } catch (e) {
              CustomWidgets.snackBarCustom(context, massage: "Invalid price");
              return;
            }
          }
        }
        FirebaseFirestore.instance
            .collection("Menus")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(widget.myMenuIteamList!.toMap())
            .then((value) {
          CustomWidgets.snackBarCustom(context, massage: "Datails Updated");
          Navigator.pop(context);
        });
      }
    }
  }
}
