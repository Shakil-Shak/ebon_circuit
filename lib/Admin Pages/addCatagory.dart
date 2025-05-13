// ignore: file_names
// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'dart:io';

import 'package:ebon_circuit/color.dart';
import 'package:ebon_circuit/modelsPages/menu_model.dart';
import 'package:ebon_circuit/customWidgets/custom_text.dart';
import 'package:ebon_circuit/customWidgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class AddCatagory extends StatefulWidget {
  MenuModelFirebaseSetData? myMenuIteamList;

  bool enable;
  String? catagoriName;
  AddCatagory(
      {required this.myMenuIteamList,
      required this.enable,
      this.catagoriName,
      super.key});

  @override
  _AddCatagory createState() => _AddCatagory();
}

class _AddCatagory extends State<AddCatagory> {
  TextEditingController catagoryController = TextEditingController();
  TextEditingController iteamNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountontroller = TextEditingController();
  File? imageFile;
  List<File> _additionalImages = [];

  @override
  void initState() {
    super.initState();
    if (!widget.enable) {
      catagoryController.text = widget.catagoriName!;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _additionalImages.add(File(pickedFile.path));
      });
    }
  }

  Future<String> _uploadFile(File file, String path) async {
    try {
      Reference storage = FirebaseStorage.instance
          .ref()
          .child("Menu Images")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(const Uuid().v6());

      final uploadTask = storage.putFile(file);
      await uploadTask.whenComplete(() {});
      final downloadUrl = await storage.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload file: $e')));
      return "";
    }
  }

  Future<List<String>> _uploadImages(List<File> images) async {
    final imageUrls = <String>[];
    for (File image in images) {
      String path =
          'projects/images/${DateTime.now().millisecondsSinceEpoch}.png';
      String url = await _uploadFile(image, path);
      imageUrls.add(url);
    }
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText((!widget.enable) ? "Add a iteam" : "Add a Catagory"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidgets.textFormFieldCustom(
                  width: double.infinity,
                  enabled: widget.enable,
                  text: "Catagory Name",
                  controller: catagoryController),
              const SizedBox(
                height: 16,
              ),
              CustomWidgets.textFormFieldCustom(
                  width: double.infinity,
                  text: "Iteam Name",
                  controller: iteamNameController),
              const SizedBox(
                height: 16,
              ),
              CustomWidgets.textFormFieldCustom(
                  width: double.infinity,
                  text: "Description",
                  maxLine: 4,
                  controller: descriptionController),
              const SizedBox(
                height: 16,
              ),
              CustomWidgets.textFormFieldCustom(
                  width: double.infinity,
                  text: "Price",
                  controller: priceController),
              const SizedBox(
                height: 16,
              ),
              CustomWidgets.textFormFieldCustom(
                  width: double.infinity,
                  text: "Discount",
                  controller: discountontroller),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  imageDialogChooser();
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow),
                      borderRadius: BorderRadius.circular(20)),
                  child: (imageFile != null)
                      ? Image(image: FileImage(imageFile!))
                      : const Center(
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(height: 16),
              customText('Additional Images', fontWeigth: FontWeight.bold),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _additionalImages
                    .map((image) => Stack(
                          children: [
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: 2, color: Colors.black)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(image)),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon: Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _additionalImages.remove(image);
                                  });
                                },
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text('Add Additional Image'),
              ),
              const SizedBox(height: 16),

              CustomWidgets.elevatedButtonCustom(
                  hintText: "Add",
                  onPressedButton: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                    if (catagoryController.text.length > 2 &&
                        iteamNameController.text.length > 2 &&
                        priceController.text.isNotEmpty &&
                        imageFile != null) {
                      const CircularProgressIndicator();

                      try {
                        double? price = double.tryParse(priceController.text);

                        if (price == null) {
                          CustomWidgets.snackBarCustom(context,
                              massage: "invalid price");
                          return;
                        }
                        imageUploadToFirebase(
                          iteamName: iteamNameController.text,
                          catagory: catagoryController.text,
                          description: descriptionController.text,
                          price: price,
                        );
                      } catch (e) {
                        CustomWidgets.snackBarCustom(context,
                            massage: "invalid price");
                      }
                    } else {
                      CustomWidgets.snackBarCustom(context,
                          massage: "Provied All Data");
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              // customText("You can add more locations\non edit panel",
              //     alinment: TextAlign.center, softWrap: true),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void imageDialogChooser() {
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text("Choose from gerally"),
                  onTap: () {
                    Navigator.pop(context);
                    image_picker(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("take a picture"),
                  onTap: () {
                    Navigator.pop(context);
                    image_picker(ImageSource.camera);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void image_picker(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      String? path = file.path;
      print("image android picked");

      setState(() {
        imageFile = File(path);
      });
    }
  }

  void imageUploadToFirebase(
      {required String iteamName,
      required String catagory,
      String? description,
      double? price}) async {
    // String imageName = imageFile!.path.split('/').last;
    Reference storage = FirebaseStorage.instance
        .ref()
        .child("Menu Images")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(const Uuid().v6());
    try {
      await storage
          .putFile(imageFile!, SettableMetadata(contentType: 'image/jpeg'))
          .then((value) {
        storage.getDownloadURL().then((value) async {
          // Separate local files and URLs
          List<File> localFiles = _additionalImages;
          List<String> uploadedUrls = [];
          try {
            if (localFiles.isNotEmpty) {
              uploadedUrls = await _uploadImages(localFiles);
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Failed to upload additional images: $e')));
          }

          addCatagoryToMenuIteamListAndFirebase(
              catagory: catagory,
              iteamName: iteamName,
              imagePath: value,
              description: description,
              additionalImages: uploadedUrls,
              price: price);
        });
      });
    } on FirebaseException {
      SnackBar(content: customText("An error occoured"));
    }
  }

  void addCatagoryToMenuIteamListAndFirebase(
      {required String iteamName,
      required String catagory,
      String? description,
      double? price,
      List<String>? additionalImages,
      required String imagePath}) {
    bool isCatagoryExist = false;
    if (widget.myMenuIteamList != null &&
        widget.myMenuIteamList!.menuIteamList!.isNotEmpty) {
      for (int i = 0; i < widget.myMenuIteamList!.menuIteamList!.length; i++) {
        if (widget.myMenuIteamList!.menuIteamList![i].menuName == catagory) {
          isCatagoryExist = true;
          bool isIteamExist = false;
          for (int j = 0;
              j < widget.myMenuIteamList!.menuIteamList![i].iteams!.length;
              j++) {
            if (widget
                    .myMenuIteamList!.menuIteamList![i].iteams![j].iteamName ==
                iteamName) {
              isIteamExist = true;
              CustomWidgets.snackBarCustom(context,
                  massage: "This iteam already exist");
            }
          }
          if (isIteamExist == false) {
            widget.myMenuIteamList!.menuIteamList![i].iteams!.add(
                MenuIteamModel(
                    id: Uuid().v4().toString(),
                    iteamName: iteamName,
                    iteamImagePath: imagePath,
                    description: description,
                    discount: double.tryParse(discountontroller.text) ?? 0.0,
                    price: price));
            FirebaseFirestore.instance
                .collection("Menus")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set(widget.myMenuIteamList!.toMap())
                .then((value) => Navigator.pop(context));
          }
        }
      }
    }
    if (isCatagoryExist == false) {
      widget.myMenuIteamList ??= MenuModelFirebaseSetData(menuIteamList: []);
      widget.myMenuIteamList!.menuIteamList!
          .add(MenuModel(menuName: catagory, iteams: [
        MenuIteamModel(
            id: Uuid().v4().toString(),
            iteamName: iteamName,
            additionalImages: additionalImages,
            iteamImagePath: imagePath,
            discount: double.tryParse(discountontroller.text) ?? 0.0,
            description: description,
            price: price)
      ]));
      FirebaseFirestore.instance
          .collection("Menus")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(widget.myMenuIteamList!.toMap())
          .then((value) {
        Navigator.pop(context);
        setState(() {});
      });
    }
    Navigator.pop(context);
  }
}
