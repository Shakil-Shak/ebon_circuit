import 'package:ebon_circuit/modelsPages/iteam_model.dart';

class OrderModel {
  final List<IteamModel> orderList;
  String orderCondition;

  OrderModel({required this.orderList, required this.orderCondition});

  Map<String, dynamic> toMap() {
    return {
      'orderList': orderList.map((item) => item.toMap()).toList(),
      'orderCondition': orderCondition
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
        orderList: List<IteamModel>.from(
            map['orderList'].map((x) => IteamModel.fromMap(x))),
        orderCondition: map['orderCondition'] ?? "pending");
  }
}

class OrderListModel {
  final List<OrderModel> orders;

  OrderListModel({required this.orders});

  Map<String, dynamic> toMap() {
    return {
      'orders': orders.map((order) => order.toMap()).toList(),
    };
  }

  factory OrderListModel.fromMap(Map<String, dynamic> map) {
    return OrderListModel(
      orders: List<OrderModel>.from(
        map['orders'].map(
          (order) => OrderModel.fromMap(order),
        ),
      ),
    );
  }
}
