class MenuModelFirebaseSetData {
  List<MenuModel>? menuIteamList;
  MenuModelFirebaseSetData({required this.menuIteamList});

  Map<String, dynamic> toMap() {
    return {
      'menuIteamList': menuIteamList!.map((value) => value.toMap()).toList(),
    };
  }

  factory MenuModelFirebaseSetData.fromMap(Map<String, dynamic> map) {
    List<dynamic> loadedMenu = map['menuIteamList'] ?? [];
    List<MenuModel> menuIteamList =
        loadedMenu.map((value) => MenuModel.fromMap(value)).toList();

    return MenuModelFirebaseSetData(menuIteamList: menuIteamList);
  }
}

class MenuModel {
  String? uid;
  String? menuName;
  List<MenuIteamModel>? iteams;

  MenuModel({this.uid, this.menuName, this.iteams});

  Map<String, dynamic> toMap() {
    return {
      'menu_name': menuName,
      'iteams': iteams!.map((value) => value.toMap())
    };
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> loadedMenu = map['iteams'] ?? [];
    List<MenuIteamModel> menuIteamList =
        loadedMenu.map((value) => MenuIteamModel.fromMap(value)).toList();
    return MenuModel(iteams: menuIteamList, menuName: map['menu_name']);
  }
}

class MenuIteamModel {
  String? iteamName;
  String? iteamImagePath;
  String? description;
  double? price;
  double? discount;
  String? id;
  List<String>? additionalImages;

  MenuIteamModel({
    required this.id,
    this.iteamName,
    this.iteamImagePath,
    this.description,
    this.price,
    this.discount,
    this.additionalImages,
  });

  // Convert the model to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'iteam_name': iteamName,
      'iteam_image_path': iteamImagePath,
      'description': description,
      'price': price,
      'discount': discount,
      'additional_images': additionalImages,
    };
  }

  // Create a model from a map
  MenuIteamModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    iteamName = map['iteam_name'];
    iteamImagePath = map['iteam_image_path'];
    description = map['description'];
    price = map['price'];
    discount = map['discount'] ?? 0.0;
    additionalImages = List<String>.from(map['additional_images'] ?? []);
  }
}
