import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebon_circuit/Admin%20Pages/app_amdin_helper.dart';
import 'package:ebon_circuit/customWidgets/custom_text.dart';
import 'package:ebon_circuit/customWidgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import '../../modelsPages/orders_models.dart';

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = true;

  List<_UserOrderInfo> pendingOrders = [];
  List<_UserOrderInfo> confirmedOrders = [];
  List<_UserOrderInfo> rejectedOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchAllOrders();
  }

  Future<void> fetchAllOrders() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection("Orders")
          .doc(appId)
          .collection("ordersList")
          .get();

      List<_UserOrderInfo> pending = [];
      List<_UserOrderInfo> confirmed = [];
      List<_UserOrderInfo> rejected = [];

      for (var doc in querySnapshot.docs) {
        final userId = doc.id;
        final data = doc.data();
        final orderListModel = OrderListModel.fromMap(data);

        for (int i = 0; i < orderListModel.orders.length; i++) {
          final order = orderListModel.orders[i];
          final orderInfo = _UserOrderInfo(
            userId: userId,
            orderIndex: i,
            orderModel: order,
          );

          if (order.orderCondition == "pending") {
            pending.add(orderInfo);
          } else if (order.orderCondition == "confirmed") {
            confirmed.add(orderInfo);
          } else if (order.orderCondition == "rejected") {
            rejected.add(orderInfo);
          }
        }
      }

      setState(() {
        pendingOrders = pending;
        confirmedOrders = confirmed;
        rejectedOrders = rejected;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }

  Future<void> updateOrderStatus(
      String userId, int orderIndex, String newStatus) async {
    final docRef = FirebaseFirestore.instance
        .collection("Orders")
        .doc(appId)
        .collection("ordersList")
        .doc(userId);

    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final orderListModel = OrderListModel.fromMap(data);

      // Update order condition
      orderListModel.orders[orderIndex].orderCondition = newStatus;

      // Update Firestore
      await docRef.set(orderListModel.toMap());

      // Refresh local state
      fetchAllOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Orders Panel"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Pending"),
            Tab(text: "Confirmed"),
            Tab(text: "Rejected"),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(pendingOrders, showActions: true),
                _buildOrderList(confirmedOrders),
                _buildOrderList(rejectedOrders),
              ],
            ),
    );
  }

  Widget _buildOrderList(List<_UserOrderInfo> orders,
      {bool showActions = false}) {
    if (orders.isEmpty) {
      return const Center(child: Text("No orders found"));
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final userOrder = orders[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("User ID: ${userOrder.userId}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Text("Status: ${userOrder.orderModel.orderCondition}"),
              const Divider(height: 20),
              ...userOrder.orderModel.orderList.map(
                (item) => ListTile(
                  title: item.iteam != null
                      ? customText(item.iteam!.iteamName ?? "")
                      : const Text("Unnamed Item"),
                  subtitle: Text("Quantity: ${item.quantity}"),
                  trailing: item.iteam != null
                      ? customText("Tk ${item.iteam!.price}")
                      : const Text(""),
                ),
              ),
              if (showActions)
                Row(
                  children: [
                    Expanded(
                      child: CustomWidgets.elevatedButtonCustom(
                        hintText: "Approve",
                        fontSize: 14,
                        colour: Colors.green.shade700,
                        onPressedButton: () => updateOrderStatus(
                            userOrder.userId,
                            userOrder.orderIndex,
                            "confirmed"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomWidgets.elevatedButtonCustom(
                        colour: Colors.red,
                        hintText: "Reject",
                        fontSize: 14,
                        onPressedButton: () => updateOrderStatus(
                            userOrder.userId, userOrder.orderIndex, "rejected"),
                      ),
                    ),
                  ],
                )
            ]),
          ),
        );
      },
    );
  }
}

class _UserOrderInfo {
  final String userId;
  final int orderIndex;
  final OrderModel orderModel;

  _UserOrderInfo({
    required this.userId,
    required this.orderIndex,
    required this.orderModel,
  });
}
