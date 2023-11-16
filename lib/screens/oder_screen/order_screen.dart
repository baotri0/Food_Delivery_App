import 'package:flutter/material.dart';

import '../../firebase_helper/firebase_firestore.dart';
import '../../models/order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Your Orders",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Stream.fromFuture(
          FirebaseFirestoreHelper.instance.getUserOrder(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return const Center(
              child: Text("No Order Found"),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.3)),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.3)),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          height: 150,
                          width: 120,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          child: Image.network(
                            orderModel.products[0].image,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Customer: ${orderModel.customer}",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                "Address: ${orderModel.address}",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                "Phone: ${orderModel.phone}",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                "Total Price: \$${orderModel.totalPrice.toString()}",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                "Order Status: ${orderModel.status}",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              orderModel.status == "Pending"
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        await FirebaseFirestoreHelper.instance
                                            .updateOrder(orderModel, "Cancel");
                                        orderModel.status = "Cancel";
                                        setState(() {});
                                      },
                                      child: Text("Cancel"),
                                    )
                                  : SizedBox.fromSize(),
                              orderModel.status == "Delivery"
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        await FirebaseFirestoreHelper.instance
                                            .updateOrder(
                                                orderModel, "Completed");
                                        orderModel.status = "Completed";
                                        setState(() {});
                                      },
                                      child: Text("Delivered"),
                                    )
                                  : SizedBox.fromSize(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? [
                            const Text("Details"),
                            Divider(color: Theme.of(context).primaryColor),
                            ...orderModel.products.map((singleProduct) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 6.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5),
                                          child: Image.network(
                                            singleProduct.image,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                singleProduct.name,
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Quanity: ${singleProduct.qty.toString()}",
                                                    style: const TextStyle(
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12.0,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Price: \$${singleProduct.price.toString()}",
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                        color: Theme.of(context).primaryColor),
                                  ],
                                ),
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
