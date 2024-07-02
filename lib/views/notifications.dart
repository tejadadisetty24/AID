import 'package:flutter/material.dart';
import 'package:sos/export.dart';
import 'package:sos/views/notification_view.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        toolbarHeight: 104,
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          "Notifications",
          style: TextView.text70010Black.copyWith(
            fontSize: 18,
          ),
        ),
        elevation: 0,
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Navigate to the detailed information page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PersonDetailsPage(
                      name: "Ritesh Kumar",
                      age: 30,
                      bloodGroup: "O+",
                      address:
                          "123 Main Street asdf sadfs dsafs wgdfg sadfdfg fhgs fghsg jsdahgds dusafjash sdfjhsdjf dshfksjdf idjhfkgjdfsg khgkjdhfg kdffjghbkjdsfhg ",
                      pincode: "12345",
                      currentLocation: "City, Country",
                      coordinates: "Latitude: 123, Longitude: 456",
                    ),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/X.png'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Ritesh Kumar is in an emergency, he needs blood",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
