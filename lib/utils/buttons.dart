import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sos/export.dart';

class Buttons {
  solidButton(Function() function, String name) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 60,
        // width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.black),
          ),
        ),
      ),
    );
  }

  solidButtonwithIcon(Null Function() fun, String name, IconData icon) {
    return InkWell(
      onTap: fun,
      child: Container(
        width: 111,
        height: 42,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.black,
                  fontWeight: FontWeight.w600),
            ),
            Icon(icon)
          ],
        ),
      ),
    );
  }

  drawer(BuildContext context) {
    return Drawer(
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
                        backgroundImage: MemoryImage(base64Decode('')),
                      ),
                    ),
                    height(13),
                    Text(
                      "",
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
                        );
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
                      child: InkWell(
                        child: const Text(
                          "Version - 1.0",
                          style: TextView.text40014black,
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
