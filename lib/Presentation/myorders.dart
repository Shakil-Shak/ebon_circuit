import 'package:ebon_circuit/Admin%20Pages/app_amdin_helper.dart';
import 'package:ebon_circuit/color.dart';
import 'package:ebon_circuit/customWidgets/custom_backend.dart';
import 'package:ebon_circuit/customWidgets/custom_text.dart';
import 'package:ebon_circuit/modelsPages/iteam_model.dart';
import 'package:ebon_circuit/modelsPages/orders_models.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  _MyOrders createState() => _MyOrders();
}

class _MyOrders extends State<MyOrders> {
  OrderListModel? orders;

  bool ordersLoaded = false;

  @override
  void initState() {
    super.initState();
    orderLoaderCaller();
  }

  void orderLoaderCaller() async {
    String userId = await getUserId();
    print(userId + "....................");
    orders = await CustomBackEnd.fetchOrderListFromFirestore(appId, userId);
    print(orders);
    ordersLoaded = true;
    print(ordersLoaded);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (orders != null &&
              ordersLoaded == true &&
              orders!.orders.isNotEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 2,
                          color: primaryColor,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: orders!.orders.length,
                      itemBuilder: (context, index) {
                        OrderModel order = orders!.orders[index];
                        return Column(
                          children: [
                            Column(
                              children: List.generate(
                                order.orderList.length,
                                (index2) {
                                  IteamModel iteam = order.orderList[index2];
                                  return ListTile(
                                    title: customText(
                                      "${iteam.iteam!.iteamName} x${iteam.quantity}",
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        customText(
                                          "Tk: ${iteam.iteam!.price ?? 0.0 * iteam.quantity}   ",
                                        ),
                                      ],
                                    ),
                                    subtitle: customText(
                                        "Order Condition: ${order.orderCondition}",
                                        size: 12),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : (ordersLoaded == false)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: customText("No Odered found"),
                ),
    );
  }
}
