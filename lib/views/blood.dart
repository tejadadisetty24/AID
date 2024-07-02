// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/export.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Blood extends StatefulWidget {
  final String bloodType;
  const Blood({Key? key, required this.bloodType}) : super(key: key);

  @override
  State<Blood> createState() => _BloodState();
}

class _BloodState extends State<Blood> {
  isCertified() async {
    var prefs = await SharedPreferences.getInstance();
    var res = await http
        .get(Uri.parse('${baseUrl}isCertified/${prefs.getString('userId')!}'));
    var body = json.decode(res.body);
    setState(() {
      prefs.setBool('certified', body['certified']);
      isCertifiedu = body['certified'];
    });
  }

  @override
  void initState() {
    super.initState();
    isCertified();
  }

  bool isCertifiedu = false;
  String hour = DateTime.now().hour.toString();
  String minute = DateTime.now().minute.toString().length == 1
      ? "0${DateTime.now().minute}"
      : DateTime.now().minute.toString();
  String dropdownvalue = "A+";
  DateTime selectedDate = DateTime.now(); // Stores the selected date of birth
  int age = 0;
  String? patientnameErrorText;
  String? mobilenumberErrorText;
  String? hospitalNameErrorText;
  String? hospitaladdressErrorText;
  String? citynumberErrorText;
  String? pincodeErrorText;
  String? purposeofbloodErrorText;
  String? nameErrortext;
  String? placeErrortext;
  bool submitted = false;

  // Stores the calculated age

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the initial date to the current date
      firstDate: DateTime.now(), // Set the minimum selectable date
      lastDate:
          DateTime(DateTime.now().year + 15), // Set the maximum selectable date
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  var bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];
  bool loading = false;
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
          widget.bloodType,
          style: TextView.text70010Black.copyWith(
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: widget.bloodType == "Blood Checkup"
          ? !loading
              ? !isCertifiedu
                  ? SingleChildScrollView(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 28.0,
                            horizontal: 21,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Name",
                                style: TextView.text60015black,
                              ),
                              height(14),
                              CustomField(
                                hint: "",
                                label: "",
                                controller: BloodCheckUp.name,
                                suffixFunction: () {},
                                suffixIcon: const Text(""),
                                onChanged: (value) {
                                  setState(() {
                                    // Update error text dynamically based on text field content
                                    nameErrortext = value.isEmpty
                                        ? "Name is required"
                                        : null;
                                  });
                                },
                                errorText: nameErrortext,
                              ),
                              height(20),
                              const Text(
                                "Mobile",
                                style: TextView.text60015black,
                              ),
                              height(14),
                              CustomField(
                                hint: "",
                                label: "",
                                controller: BloodCheckUp.mobile,
                                keyboardType: TextInputType.phone,
                                suffixFunction: () {},
                                suffixIcon: const Text(""),
                                maxLength: 10,
                                onChanged: (value) {
                                  setState(() {
                                    // Update error text dynamically based on text field content
                                    mobilenumberErrorText = value.isEmpty
                                        ? "Mobile number is required"
                                        : null;
                                  });
                                },
                                errorText: mobilenumberErrorText,
                              ),
                              height(20),

                              const Text(
                                "Place",
                                style: TextView.text60015black,
                              ),
                              height(14),
                              CustomField(
                                hint: "",
                                label: "",
                                controller: BloodCheckUp.place,
                                suffixFunction: () {},
                                suffixIcon: const Text(""),
                                onChanged: (value) {
                                  setState(() {
                                    // Update error text dynamically based on text field content
                                    placeErrortext = value.isEmpty
                                        ? "Place is required"
                                        : null;
                                  });
                                },
                                errorText: placeErrortext,
                              ),
                              height(20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Pincode",
                                    style: TextView.text60015black,
                                  ),
                                  height(14),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35, // Set the width to half of the screen width
                                    alignment: Alignment.centerLeft,
                                    child: CustomField(
                                      hint: "",
                                      label: "",
                                      controller: BloodCheckUp.pinCode,
                                      suffixFunction: () {},
                                      onChanged: (value) {
                                        setState(() {
                                          // Update error text dynamically based on text field content
                                          pincodeErrorText = value.isEmpty
                                              ? "Pincode is required"
                                              : null;
                                        });
                                      },
                                      errorText: pincodeErrorText,
                                    ),
                                  ),
                                ],
                              ),

                              height(28),

                              // const Text(
                              //   "Purpose of Blood",
                              //   style: TextView.text60015black,
                              // ),
                              // height(14),
                              // CustomField(
                              //   max: 10,
                              //   hint: "",
                              //   label: "",
                              //   controller: TxtCtrl.brefing,
                              //   suffixFunction: () {},
                              //   suffixIcon: Text(""),
                              // ),

                              height(45),
                              Buttons().solidButton(() {
                                if (BloodCheckUp.name.text.isEmpty ||
                                    BloodCheckUp.mobile.text.isEmpty ||
                                    BloodCheckUp.pinCode.text.isEmpty ||
                                    BloodCheckUp.place.text.isEmpty) {
                                  // Show a Snackbar if any field is empty
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please fill in all fields'),
                                    ),
                                  );
                                  return; // Exit the function if any field is empty
                                }
                                // Check if the mobile number is empty or does not have exactly 10 digits
                                if (BloodCheckUp.mobile.text.isEmpty ||
                                    BloodCheckUp.mobile.text.length != 10) {
                                  // Show a Snackbar if the mobile number is empty or does not have exactly 10 digits
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please enter a valid 10-digit mobile number'),
                                    ),
                                  );
                                  return; // Exit the function if the mobile number is not valid
                                }

                                // If the mobile number is valid, proceed with the submission action
                                bloodCheckUpSubmit();

                                // Clear the text fields after submission
                              }, "submit"),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text('get llost'),
                    )
              : const Center(child: CircularProgressIndicator())
          : !loading
              ? SingleChildScrollView(
                  child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 28.0,
                    horizontal: 21,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Patient Name",
                          style: TextView.text60015black,
                        ),
                        height(14),
                        CustomField(
                          hint: "",
                          label: "",
                          controller: widget.bloodType == 'Blood Emergency'
                              ? BloodEm.name
                              : BloodReq.name,
                          suffixFunction: () {},
                          suffixIcon: const Text(""),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter patient name';
                            }
                          },
                          errorText: patientnameErrorText,
                          onChanged: (value) {
                            setState(() {
                              // Update error text dynamically based on text field content
                              patientnameErrorText = value.isEmpty
                                  ? "Patient Name is required"
                                  : null;
                            });
                          },
                        ),
                        height(20),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.bloodType != "Blood Emergency"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Date",
                                          style: TextView.text60015black,
                                        ),
                                        height(13),
                                        InkWell(
                                          onTap: () {
                                            _showDatePicker(context);
                                          },
                                          child: Container(
                                            width: 127,
                                            height: 50,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 17),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                  width: 1,
                                                  color:
                                                      const Color(0x80EEEEEE),
                                                )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  selectedDate
                                                      .toString()
                                                      .split(" ")[0],
                                                  style: TextView
                                                      .text50011superLight
                                                      .copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.black,
                                                  size: 25,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Blood Type",
                                    style: TextView.text60015black,
                                  ),
                                  height(13),
                                  Container(
                                    width: 127,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          width: 1,
                                          color: const Color(0x80EEEEEE),
                                        )),
                                    alignment: Alignment.center,
                                    child: DropdownButton(
                                      elevation: 0,
                                      underline: const Text(""),
                                      value: dropdownvalue,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: bloodGroups.map((bloodGroup) {
                                        return DropdownMenuItem(
                                          value: bloodGroup,
                                          child: Text(bloodGroup),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          dropdownvalue = newValue.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        height(27),
                        const Text(
                          "Mobile",
                          style: TextView.text60015black,
                        ),
                        height(14),
                        CustomField(
                          hint: "",
                          label: "",
                          controller: widget.bloodType == 'Blood Emergency'
                              ? BloodEm.mobile
                              : BloodReq.mobile,
                          suffixFunction: () {},
                          suffixIcon: const Text(""),
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email/mobile';
                            } else {
                              // Check if the input value is a valid email address
                              if (RegExp(
                                      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$')
                                  .hasMatch(value)) {
                                return null; // Return null if the input value is a valid email address
                              }
                              // Check if the input value is a valid mobile number (10 digits)
                              if (RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return null; // Return null if the input value is a valid mobile number
                              }
                              // If the input value is neither a valid email address nor a valid mobile number, return an error message
                              return 'Please enter a valid email address or mobile number';
                            }
                          },
                          errorText: mobilenumberErrorText,
                          onChanged: (value) {
                            setState(() {
                              // Update error text dynamically based on text field content
                              mobilenumberErrorText = value.isEmpty
                                  ? "Mobile Number is required"
                                  : null;
                            });
                          },
                        ),

                        height(20),
                        const Text(
                          "Hospital Name",
                          style: TextView.text60015black,
                        ),
                        height(14),
                        CustomField(
                          validator: (value) {},
                          errorText: hospitalNameErrorText,
                          onChanged: (value) {
                            setState(() {
                              // Update error text dynamically based on text field content
                              hospitalNameErrorText = value.isEmpty
                                  ? "Hospital Name is required"
                                  : null;
                            });
                          },
                          hint: "",
                          label: "",
                          controller: widget.bloodType == 'Blood Emergency'
                              ? BloodEm.place
                              : BloodReq.place,
                          suffixFunction: () {},
                          suffixIcon: const Text(""),
                        ),
                        height(20),
                        const Text(
                          "Hospital Address",
                          style: TextView.text60015black,
                        ),
                        height(14),
                        CustomField(
                          hint: "",
                          label: "",
                          controller: widget.bloodType == 'Blood Emergency'
                              ? BloodEm.address
                              : BloodReq.address,
                          suffixFunction: () {},
                          suffixIcon: const Text(""),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter hospital address';
                            }
                          },
                          errorText: hospitaladdressErrorText,
                          onChanged: (value) {
                            setState(() {
                              // Update error text dynamically based on text field content
                              hospitaladdressErrorText = value.isEmpty
                                  ? "Hospital address is required"
                                  : null;
                            });
                          },
                        ),
                        height(20),
                        Row(
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: CustomField(
                                  controller:
                                      widget.bloodType == 'Blood Emergency'
                                          ? BloodEm.city
                                          : BloodReq.city,
                                  hint: "",
                                  label: "City",
                                  suffixFunction: () {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'enter city';
                                    }
                                  },
                                  errorText: citynumberErrorText,
                                  onChanged: (value) {
                                    setState(() {
                                      // Update error text dynamically based on text field content
                                      citynumberErrorText = value.isEmpty
                                          ? "city Name is required"
                                          : null;
                                    });
                                  } // suffixIcon: Text(""),
                                  ),
                            ),
                            width(12),
                            Flexible(
                              fit: FlexFit.loose,
                              child: CustomField(
                                  controller:
                                      widget.bloodType == 'Blood Emergency'
                                          ? BloodEm.pin
                                          : BloodReq.pin,
                                  hint: "",
                                  label: "Pin Code",
                                  keyboardType: TextInputType.phone,
                                  suffixFunction: () {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'enter pincode';
                                    }
                                  },
                                  errorText: pincodeErrorText,
                                  onChanged: (value) {
                                    setState(() {
                                      // Update error text dynamically based on text field content
                                      pincodeErrorText = value.isEmpty
                                          ? "Pin Code is required"
                                          : null;
                                    });
                                  }
                                  // suffixIcon: Text(""),
                                  ),
                            )
                          ],
                        ),

                        // CustomField(
                        //   hint: "",
                        //   label: "City",
                        //   controller: BloodEm.place,
                        //   suffixFunction: () {},
                        //   suffixIcon: const Text(""),
                        // ),
                        // height(20),
                        // CustomField(y
                        //   hint: "",
                        //   label: "Pin Code",
                        //   controller: BloodEm.place,
                        //   suffixFunction: () {},
                        //   suffixIcon: const Text(""),
                        // ),
                        height(20),
                        const Text(
                          "Purpose of Blood",
                          style: TextView.text60015black,
                        ),
                        height(14),
                        CustomField(
                            max: 10,
                            hint: "",
                            label: "",
                            controller: widget.bloodType == 'Blood Emergency'
                                ? BloodEm.purpose
                                : BloodReq.purpose,
                            suffixFunction: () {},
                            suffixIcon: const Text(""),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter Purpose of blood';
                              }
                            },
                            errorText: purposeofbloodErrorText,
                            onChanged: (value) {
                              setState(() {
                                // Update error text dynamically based on text field content
                                purposeofbloodErrorText = value.isEmpty
                                    ? "Purpose Of Blood is required"
                                    : null;
                              });
                            }),
                        height(45),
                        Buttons().solidButton(() {
                          if (widget.bloodType == 'Blood Emergency') {
                            if (BloodEm.name.text.isEmpty ||
                                BloodEm.mobile.text.isEmpty ||
                                BloodEm.place.text.isEmpty ||
                                BloodEm.pin.text.isEmpty ||
                                BloodEm.city.text.isEmpty ||
                                BloodEm.name.text.isEmpty ||
                                BloodEm.address.text.isEmpty |
                                    BloodEm.purpose.text.isEmpty) {
                              // Show a Snackbar if any field is empty
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter all the fields'),
                                ),
                              );
                              return; // Exit the function if any field is empty
                            }
                            // If all fields are filled, proceed with the form submission
                            bloodEm();
                            // Clear the text fields
                            BloodEm.name.clear();
                            BloodEm.mobile.clear();
                            BloodEm.pin.clear();
                            BloodEm.place.clear();
                            BloodEm.address.clear();
                            BloodEm.city.clear();
                            BloodEm.purpose.clear();
                          } else {
                            if (BloodReq.name.text.isEmpty ||
                                BloodReq.mobile.text.isEmpty ||
                                BloodReq.place.text.isEmpty ||
                                BloodReq.pin.text.isEmpty ||
                                BloodReq.city.text.isEmpty ||
                                BloodReq.name.text.isEmpty ||
                                BloodReq.address.text.isEmpty |
                                    BloodReq.purpose.text.isEmpty) {
                              // Show a Snackbar if any field is empty
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter all the fields'),
                                ),
                              );
                              return; // Exit the function if any field is empty
                            }
                            // If all fields are filled, proceed with the form submission
                            bloodReq();
                            // Clear the text fields
                          }
                        }, "Submit")
                      ]),
                ))
              : const Center(child: CircularProgressIndicator()),
    );
  }

  bloodCheckUpSubmit() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        loading = true;
      });

      var res = await http.post(Uri.parse('${baseUrl}bloodcheckup'),
          headers: {"content-type": 'application/json', 'UserId': "123"},
          body: jsonEncode({
            "userId": "${sharedPrefs.getString('userId')}",
            "time": "$hour:$minute",
            "name": BloodCheckUp.name.text,
            "mobileNumber": BloodCheckUp.mobile.text,
            "place": BloodCheckUp.place.text,
            "pincode": BloodCheckUp.pinCode.text,
            "status": "pending",
            "coordinatesLatitude": latitude,
            "coordinatesLongitude": longitute,
          }));
      if (res.statusCode == 200) {
        BloodCheckUp.name.clear();
        BloodCheckUp.mobile.clear();
        BloodCheckUp.pinCode.clear();
        BloodCheckUp.place.clear();
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "Request Submitted",
            ),
          ),
        );
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          "Issue With Report Submission",
        ),
      ));
    }
  }

  bloodEm() async {
    try {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            "Request Submitted",
          ),
        ),
      );
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          "Issue With Report Submission",
        ),
      ));
    }
  }

  bloodReq() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    var res = await http.post(Uri.parse('${baseUrl}blood-requirements'),
        headers: {"content-type": 'application/json', 'UserId': "123"},
        body: jsonEncode({
          "userId": "${sharedPrefs.getString('userId')}",
          "patientName": BloodReq.name.text,
          "date": selectedDate.toIso8601String(),
          "time": "${selectedDate.hour}:${selectedDate.minute}",
          "bloodType": dropdownvalue,
          "mobileNumber": BloodReq.mobile.text,
          "hospitalName": BloodReq.place.text,
          "hospitalAddress": BloodReq.address.text,
          "location": BloodReq.city.text,
          "pincode": BloodReq.pin.text,
          "purposeOfBlood": BloodReq.purpose.text,
          "coordinatesLatitude": latitude,
          "coordinatesLongitude": longitute,
          "status": "Pending"
        }));
    if (res.statusCode == 200) {
      setState(() {
        BloodReq.name.clear();
        BloodReq.mobile.clear();
        BloodReq.pin.clear();
        BloodReq.place.clear();
        BloodReq.address.clear();
        BloodReq.city.clear();
        BloodReq.purpose.clear();
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}
