// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/utils/colors.dart';
import 'package:sos/utils/const.dart';
import 'package:sos/utils/images.dart';

class MedicalCardView extends StatefulWidget {
  const MedicalCardView({Key? key}) : super(key: key);

  @override
  State<MedicalCardView> createState() => _MedicalCardViewState();
}

class _MedicalCardViewState extends State<MedicalCardView> {
  List<Map<String, dynamic>> emergencyContacts = [];
  List<String> allergies = ["Penicillin", "Peanuts", "Dust Mines"];

  @override
  void initState() {
    super.initState();
    getEmergencyContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCardColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(Images.img),
          ),
          Positioned(
            bottom: 270,
            left: 30,
            right: 30,
            child: Container(
              height: 121,
              decoration: BoxDecoration(
                color: const Color.fromARGB(228, 239, 206, 136),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text("Emily Smith",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("January 15, 1997",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Female", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("+91 9479358202",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("25, Green Park, New Delhi, 110016",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {});
              },
              onVerticalDragEnd: (details) {
                setState(() {});
              },
              child: DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.2,
                maxChildSize: 1,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 0),
                      color: Colors.white.withOpacity(1),
                      child: ListView(
                        controller: scrollController,
                        children: [
                          const Text("Blood Group: A+",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 10),
                          const Text("Hemoglobin Level: 12.5g/dL",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 10),
                          const Text("Allergies:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: allergies.length,
                              itemBuilder: (context, index) {
                                return Text(allergies[index]);
                              },
                            ),
                          ),
                          const Text("Chronic Diseases / Conditions:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Blood Pressure:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              SizedBox(width: 10),
                              Text("Normal", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Diabetes :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "None",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Asthama :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Mild, Occasional Episodes",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Other Medical Information :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Smoking Status :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Non-Smoker",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Alchol Consumption :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Occasional",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Emergency Contacts :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: emergencyContacts.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.all(8),
                                height: 56, // Adjust height as needed
                                decoration: BoxDecoration(
                                  // color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(emergencyContacts[index]['name']),
                                        Text(emergencyContacts[index]
                                            ['relation']),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(emergencyContacts[index]
                                            ['mobileNumber']),
                                        // const Icon(Icons.edit),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getEmergencyContacts() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    try {
      final http.Response res = await http.get(
        Uri.parse('${baseUrl}contacts/${sharedPrefs.getString('userId')}'),
        headers: {
          "content-type": 'application/json',
          'UserId': "${sharedPrefs.getString('userId')}"
        },
      );
      if (res.statusCode == 200) {
        setState(() {
          emergencyContacts =
              List<Map<String, dynamic>>.from(json.decode(res.body));
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
