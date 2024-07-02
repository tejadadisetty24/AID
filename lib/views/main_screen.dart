// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/export.dart';
import 'package:http/http.dart' as http;
// ignore: duplicate_import
import "package:sos/export.dart";
import 'package:sos/views/authentication/emergencycontacts.dart';
import 'package:sos/views/medical_card.dart';

class MainSreen extends StatefulWidget {
  const MainSreen({Key? key}) : super(key: key);

  @override
  State<MainSreen> createState() => _MainSreenState();
}

class _MainSreenState extends State<MainSreen> {
  bool holding = false;
  @override
  void initState() {
    getDetails();
    isCertified();
    super.initState();
  }

  isCertified() async {
    var prefs = await SharedPreferences.getInstance();
    var res = await http.get(Uri.parse('${baseUrl}isCertified/$userid'));
    print(res.body);
    var body = json.decode(res.body);
    setState(() {
      prefs.setBool('certified', body['certified']);
      isCertifiedu = body['certified'];
    });
  }

  String firstName = "";
  String lastName = "";
  String photo = "";
  String userid = "";
  bool isCertifiedu = false;
  getDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName')!;
      lastName = prefs.getString('lastName')!;
      photo = prefs.getString('photo')!;
      isCertifiedu = prefs.getBool('certified')!;
      userid = prefs.getString('userId')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 104,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => const Notifications(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_active_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A I D',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppin',

                  ///font issue
                  shadows: [
                    Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                        offset: Offset(3, 2)),
                  ]),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: AppColors.primaryColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            vertical: 43, horizontal: 23),
                      ),
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          backgroundImage: MemoryImage(base64Decode(photo)),
                        ),
                      ),
                      height(13),
                      Text(
                        "$firstName $lastName",
                        style: TextView.text50018black.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      height(10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewProfile(),
                            ),
                          ).then((value) => getDetails());
                        },
                        child: const Text(
                          "View Profile",
                          style: TextView.text30014black,
                        ),
                      )
                    ],
                  ),
                ),
                height(40),
                Container(
                  height: 535,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        14,
                      ),
                      topRight: Radius.circular(
                        14,
                      ),
                    ),
                  ),
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      height(40),
                      InkWell(
                        child: const Text(
                          "Blood Requirement",
                          style: TextView.text50016black,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  const Blood(bloodType: "Blood Requirement"),
                            ),
                          );
                        },
                      ),
                      height(40),
                      InkWell(
                        child: const Text(
                          "Request a Callback",
                          style: TextView.text50016black,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Report(
                                        reportType: "Request a Callback",
                                      )));
                        },
                      ),
                      height(40),
                      InkWell(
                        child: const Text(
                          "Our Partners",
                          style: TextView.text50016black,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Partners(
                                isPatner: true,
                              ),
                            ),
                          );
                        },
                      ),
                      height(40),
                      InkWell(
                        child: const Text(
                          "Our Supporters",
                          style: TextView.text50016black,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Partners(
                                isPatner: false,
                              ),
                            ),
                          );
                        },
                      ),
                      height(40),
                      InkWell(
                        child: const Text(
                          "Contact Us",
                          style: TextView.text50016black,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ContactUs(),
                            ),
                          );
                        },
                      ),
                      height(40),
                      InkWell(
                        child: const Text(
                          "About Us",
                          style: TextView.text50016black,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutUs(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: const InkWell(
                          child: Text(
                            "Version - 1.0",
                            style: TextView.text40014black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                height(155),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (isCertifiedu) {
                          // Navigate to the medical card screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MedicalCard(),
                            ),
                          );
                        } else {
                          // Navigate to Blood screen or any other screen as per your condition
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  const Blood(bloodType: "Blood Checkup"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 42,
                        width: 111,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.primaryColor),
                        child: Center(
                          child: Text(
                            !isCertifiedu ? 'Blood Checkup' : "Medical Card",
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const EmergencyContacts()),
                        );
                      },
                      child: Container(
                        height: 42,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.primaryColor),
                        child: const Center(
                          child: Text(
                            'Emergency Contacts',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                height(50),
                GestureDetector(
                  child: Container(
                    width: 200,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.inner,

                          color: const Color.fromARGB(255, 175, 175, 175)
                              .withOpacity(0.2),
                          spreadRadius: 0.0,
                          blurRadius: 0.0,
                          offset: const Offset(0, 2),
                          // changes position of shadow
                        ),
                        BoxShadow(
                          blurStyle: BlurStyle.inner,
                          color: const Color.fromARGB(255, 175, 175, 175)
                              .withOpacity(0.2),
                          spreadRadius: 0.0,
                          blurRadius: 0.0,
                          offset: Offset.zero,
                        ),
                      ],
                      image: const DecorationImage(
                          image: AssetImage(Images.emergency),
                          fit: BoxFit.cover),
                    ),
                    child: const Center(
                      child: Text(
                        'Emergency',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          "Please Hold for 5 seconds",
                        ),
                      ),
                    );
                  },
                  onTapDown: (details) {
                    setState(() {
                      holding = true;
                    });
                  },

                  onLongPress: () {
                    _startHoldTimer();
                  },
                  // onTapDown: (_) {
                  //   // print(_.pointer);
                  //   _startHoldTimer();
                  // },
                  // onTapUp: (_) {
                  //   _cancelHoldTimer();
                  // },
                  // onTapCancel: () {
                  //   _cancelHoldTimer();
                  //   _showHoldMessage();
                  // },
                  // child:
                ),
                height(60),
                Buttons().solidButton(
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Report(
                              reportType: "Report an Issue",
                            ),
                          ),
                        ),
                    "Report an Issue"),
                height(30),
                Buttons().solidButton(
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Report(
                              reportType: "Anonymously Report an Issue",
                            ),
                          ),
                        ),
                    "Anonymous Report"),
                height(30),
                Buttons().solidButton(
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) =>
                                const Blood(bloodType: "Blood Emergency"),
                          ),
                        ),
                    "Blood Emergency"),
              ],
            ),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   color: Colors.amber,
          // ),
        ],
      ),
    );
  }

  void _startHoldTimer() {
  }


}
