import 'package:ebon_circuit/modelsPages/menu_model.dart';

class IteamModel {
  MenuIteamModel? iteam;
  int quantity;

  IteamModel({
    required this.iteam,
    required this.quantity,
  });
  Map<String, dynamic> toMap() {
    return {
      'iteam': iteam!.toMap(),
      'quantity': quantity,
    };
  }

  factory IteamModel.fromMap(Map<String, dynamic> map) {
    return IteamModel(
      iteam: MenuIteamModel.fromMap(map['iteam']),
      quantity: map['quantity'],
    );
  }
}
