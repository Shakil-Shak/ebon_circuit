import 'package:ebon_circuit/Presentation/checkout.dart';
import 'package:ebon_circuit/customWidgets/custom_backend.dart';
import 'package:ebon_circuit/customWidgets/custom_text.dart';
import 'package:ebon_circuit/customWidgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ebon_circuit/modelsPages/iteam_model.dart';

import '../color.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  _Cart createState() => _Cart();
}

class _Cart extends State<Cart> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<IteamModel>? iteamList;
  //  = [
  //   IteamModel(iteamName: "iteamName1", price: 1, quantity: 1),
  //   IteamModel(iteamName: "iteamName2", price: 2, quantity: 2),
  //   IteamModel(iteamName: "iteamName3", price: 3, quantity: 3),
  //   IteamModel(iteamName: "iteamName4", price: 4, quantity: 4),
  //   IteamModel(iteamName: "iteamName5", price: 5, quantity: 5),
  //   IteamModel(iteamName: "iteamName6", price: 6, quantity: 6),
  //   IteamModel(iteamName: "iteamName1", price: 7, quantity: 7),
  //   IteamModel(iteamName: "iteamName2", price: 8, quantity: 8),
  //   IteamModel(iteamName: "iteamName3", price: 9, quantity: 9),
  //   IteamModel(iteamName: "iteamName4", price: 10, quantity: 10),
  //   IteamModel(iteamName: "iteamName5", price: 11, quantity: 11),
  //   IteamModel(iteamName: "iteamName6", price: 12, quantity: 12),
  // ];
  var total = 0.0;
  bool isCartLoaded = false;

  void cartListLoaderCaller() async {
    iteamList = await CustomBackEnd.fetchCartIteamModelsFromFirestore();
    isCartLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cartListLoaderCaller();
  }

  @override
  Widget build(BuildContext context) {
    if (iteamList != null && total <= 0) {
      for (int i = 0; i < iteamList!.length; i++) {
        if (iteamList![i].iteam != null && iteamList![i].iteam!.price != null) {
          total += (iteamList![i].iteam!.price ?? 0.0 * iteamList![i].quantity);
        }
      }
    }
    return Scaffold(
      body: (iteamList != null && isCartLoaded == true && iteamList!.isNotEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.alarm_sharp,
                          size: 60,
                        ),
                        const Column(
                          children: [
                            Text(
                              'Delivery Date: ',
                            ),
                            Text(
                              'Delivery Time: ',
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            ),
                            Text(
                              selectedTime.format(context),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child:
                                    const Icon(Icons.calendar_month_rounded)),
                            InkWell(
                                child: const Icon(Icons.alarm),
                                onTap: () {
                                  _selectTime(context);
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 1,
                          color: primaryColor,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: iteamList!.length,
                      itemBuilder: (context, index) {
                        IteamModel iteam = iteamList![index];
                        return ListTile(
                          leading: InkWell(
                            onTap: () {
                              if (iteam.quantity > 0) {
                                iteam.quantity--;
                                total = total - (iteam.iteam!.price ?? 0.0);
                              }
                              setState(() {});
                            },
                            child: const CircleAvatar(
                              radius: 18,
                              child: Icon(Icons.remove),
                            ),
                          ),
                          title: Text(
                              "${iteam.iteam!.iteamName} x${iteam.quantity}",
                              style: const TextStyle(fontSize: 14)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Tk: ${iteam.iteam!.price ?? 0.0 * iteam.quantity}   ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  iteam.quantity++;
                                  total = total + (iteam.iteam!.price ?? 0.0);
                                  setState(() {});
                                },
                                child: const CircleAvatar(
                                  radius: 18,
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [
                      const ListTile(
                        title: Text("Delivery Instrusctions:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        trailing: Text(
                          "+  Add Notes",
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ),
                      ListTile(
                        title: const Text("Total:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        trailing: Text(
                          "Tk: $total",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.red),
                        ),
                      ),
                      CustomWidgets.elevatedButtonCustom(
                          hintText: "CheckOut",
                          onPressedButton: () {
                            if (total > 0) {
                              CustomWidgets.pageRouteCustom(context,
                                  pageName: Checkout(
                                      iteamList: iteamList,
                                      payablePrice: total.toDouble()));
                            } else {}
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            )
          : (isCartLoaded == false)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: customText("No Cart Iteam found"),
                ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
}
