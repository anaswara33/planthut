import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planthut/helper/sharedpref.dart';
import 'package:planthut/models/order.dart';
import 'package:planthut/screens/splash/splash_screen.dart';

import 'profile_menu.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () async {
              await showProfileDialog(context);
            },
          ),
          ProfileMenu(
            text: "Order history",
            icon: "assets/icons/Parcel.svg",
            press: () async {
              await showHistoryDialog(context);
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () async {
              await showHelpDialog(context);
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              await showAlertDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> showAlertDialog(context) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log out?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Would you like to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                await logout(context);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showProfileDialog(context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
              backgroundColor: Colors.white,
              child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Profile", style: TextStyle(fontSize: 36)),
                            Text("First Name: ${data['fname']}\n"
                                "Last Name: ${data['lname']}\n"
                                "Email: ${data['email']}\n"
                                "Phone: ${data['phone']}\n"
                                "Address: ${data['address']}\n"),
                          ],
                        ),
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  }));
        });
  }

  Future<void> logout(context) async {
    await SharedPrefHelper.clear();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(SplashScreen.routeName, (route) => false);
  }

  Future<void> showHelpDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
            backgroundColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Help", style: TextStyle(fontSize: 36)),
                  Text("Contact : 9123456780"),
                ],
              ),
            ),
          );
        });
  }

  Future<void> showHistoryDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
              backgroundColor: Colors.white,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("orders")
                      .where("uid",
                          isEqualTo: FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser.uid))
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final data = snapshot.data.docs.map((e) => Order.fromDoc(e)).toList();
                    print(snapshot.data.docs.toString());
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Orders", style: TextStyle(fontSize: 36)),
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: List.generate(data.length, (index) {
                                return OrderItem(order: data[index]);
                              }),
                            )
                          ],
                        ),
                      ),
                    );
                  }));
        });
  }
}

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Order ID: ${order.orderId}"),
        Text("Total: ${order.total}\n"
                "Delivery assigned: ${order.delivery != null ? "Yes" : "No"}\n"
                "Order date: ${order.date == null ? "NA" : DateFormat.yMd().format(order.date)}\n"
                "Items:" +
            getItemsString(order.items)),
      ],
    );
  }

  String getItemsString(List<Item> items) {
    String string = "";
    items.forEach((element) {
      string = string + "\n. ${element.pName} x${element.quantity}";
    });
    return string;
  }
}
