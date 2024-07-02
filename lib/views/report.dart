// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/export.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final RegExp emailRegex = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);

class Report extends StatefulWidget {
  final String reportType;
  const Report({Key? key, required this.reportType}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  DateTime selectedDate = DateTime.now(); // Stores the selected date of birth
  int age = 0; // Stores the calculated age
  String? emailErrorttext;
  String? mobileErrorttext;
  String? subjectErrorttext;
  String? explainErrortext;
  String? topictospeakErrortext;
  String? subjecTErrortext;
  String? mobiLEErrortext;
  String? explaininErrortext;
  String? placeErrortext;
  String? sUbjectErrortext;

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

  TimeOfDay _selectedTime = TimeOfDay.now();
  Future<void> _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  bool loading = false;
// final prefs =  SharedPreferences.getInstance();
  reportIssue() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    try {
      setState(() {
        loading = true;
      });

      var res = await http.post(Uri.parse('${baseUrl}reportedissues'),
          headers: {"content-type": 'application/json', 'UserId': "123"},
          body: jsonEncode({
            "userId": sharedPrefs.getString("userId"),
            "date": selectedDate.toIso8601String().split('T')[0],
            "time":
                "${_selectedTime.hour}:${_selectedTime.minute.toString().length == 1 ? "0${_selectedTime.minute}" : _selectedTime.minute.toString()}",
            'email': ReportIssue.email.text,
            'mobileNumber': ReportIssue.mobile.text,
            'subject': ReportIssue.subject.text,
            'explainInBreif': ReportIssue.brief.text,
            "status": "Pending",
            "name":
                "${sharedPrefs.getString('firstName')} ${sharedPrefs.getString('lastName')}",
            "coordinatesLatitude": latitude,
            "coordinatesLongitude": longitute,
          }));
      setState(() {
        loading = false;
      });
      if (res.statusCode == 200) {
        ReportIssue.brief.clear();
        ReportIssue.email.clear();
        ReportIssue.mobile.clear();
        ReportIssue.subject.clear();
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "Report Submitted",
            ),
          ),
        );
      } else {}
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            "Report not Submitted ",
          ),
        ),
      );
    }
  }

  anoRepSubmit() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    try {
      var res = await http.post(Uri.parse('${baseUrl}anonymousreport'),
          headers: {
            "content-type": 'application/json',
            'UserId': "${prefs.getString("userId")}"
          },
          body: jsonEncode({
            "reportedAccount":
                "${prefs.getString('firstName')} ${prefs.getString('lastName')}",
            "userId": prefs.getString("userId"),
            "date": selectedDate.toIso8601String().split("T")[0],
            "time":
                "${_selectedTime.hour}:${_selectedTime.minute.toString().length == 1 ? "0${_selectedTime.minute}" : _selectedTime.minute.toString()}",
            'placeOfIncident': AnoRep.place.text,
            'subject': AnoRep.subject.text,
            'explainInBreif': AnoRep.brief.text,
            "status": "Pending",
            "coordinatesLatitude": latitude,
            "coordinatesLongitude": longitute,
          }));

      if (res.statusCode == 200) {
        AnoRep.place.clear();
        AnoRep.subject.clear();
        AnoRep.brief.clear();
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "Report Submitted",
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            "Report not Submitted ",
          ),
        ),
      );
    }
  }

  callbackRequest() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    try {
      // setState(() {
      //   loading = true;
      // });
      var body = {
        "userId": "${sharedPrefs.getString('userId')}",
        "date": selectedDate.toIso8601String().split("T")[0],
        "time": "${_selectedTime.hour}:${_selectedTime.minute}",
        "subject": AnoRep.subject.text,
        "topicToSpeakAbout": AnoRep.brief.text,
        "coordinatesLatitude": latitude,
        "coordinatesLongitude": longitute,
        "status": "pending",
        "name":
            "${sharedPrefs.getString('firstName')} ${sharedPrefs.getString('lastName')}",
        "mobileNumber": AnoRep.place.text,
      };
      var res = await http.post(Uri.parse('${baseUrl}callback'),
          headers: {"content-type": 'application/json', 'UserId': "1452"},
          body: jsonEncode(body));
      /*
            callbackRequest();
       */
      /**
       * {
    "userId": "123",
    "name": "ravi",
    "date": "2023-02-02",
    "time": "12:21",
    "place": "lbnagar",
    "mobileNumber": "9876543211",
    "subject": "accident",
    "topicToSpeakAbout": "urgent blood needed",
    "coordinatesLatitude": "17.9876",
    "coordinatesLongitude": "11.987654",
    "status": "pending"
}
       */
      if (res.statusCode == 200) {
        setState(() {
          AnoRep.place.clear();
          AnoRep.subject.clear();
          AnoRep.brief.clear();

          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "Report Submitted",
            ),
          ),
        );
      } else {}
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            "Report not Submitted ",
          ),
        ),
      );
    }
  }

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
          widget.reportType,
          style: TextView.text70010Black.copyWith(
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: widget.reportType == "Report an Issue"
          ? !loading
              ? SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 28.0,
                        horizontal: 21,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
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
                                                color: const Color(0x80EEEEEE),
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                selectedDate
                                                    .toString()
                                                    .split(' ')[0],
                                                style: TextView
                                                    .text50011superLight
                                                    .copyWith(
                                                        color: Colors.black),
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
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Time",
                                        style: TextView.text60015black,
                                      ),
                                      height(13),
                                      InkWell(
                                        onTap: () {
                                          _showTimePicker();
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
                                                color: const Color(0x80EEEEEE),
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _selectedTime.format(context),
                                                style: TextView
                                                    .text50011superLight
                                                    .copyWith(
                                                        color: AppColors
                                                            .lightdark),
                                              ),
                                              const Icon(
                                                Icons.history_toggle_off,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            height(27),
                            const Text(
                              "Email",
                              style: TextView.text60015black,
                            ),
                            height(14),
                            CustomField(
                              hint: "",
                              label: "",
                              controller: ReportIssue.email,
                              keyboardType: TextInputType.emailAddress,
                              suffixFunction: () {},
                              suffixIcon: const Text(""),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email is required';
                                } else if (!RegExp(
                                        r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                                return null; // Return null if the validation succeeds
                              },
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  emailErrorttext = value.isEmpty
                                      ? "Email is required"
                                      : null;
                                });
                              },
                              errorText: emailErrorttext,
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
                              controller: ReportIssue.mobile,
                              keyboardType: TextInputType.phone,
                              suffixFunction: () {},
                              suffixIcon: const Text(""),
                              maxLength: 10,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Mobile number is required';
                                } else if (value.length != 10) {
                                  return 'Mobile number must be 10 digits';
                                } else if (!RegExp(r'^[1-9][0-9]*$')
                                    .hasMatch(value)) {
                                  return 'Mobile number should start with a digit from 1 to 9';
                                }
                                return null; // Return null if the validation succeeds
                              },
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  mobileErrorttext = value.isEmpty
                                      ? "Mobile Number is required"
                                      : null;
                                });
                              },
                              errorText: mobileErrorttext,
                            ),
                            height(20),
                            const Text(
                              "Subject",
                              style: TextView.text60015black,
                            ),
                            height(14),
                            CustomField(
                              hint: "",
                              label: "",
                              controller: ReportIssue.subject,
                              suffixFunction: () {},
                              suffixIcon: const Text(""),
                              validator: () {},
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  subjectErrorttext = value.isEmpty
                                      ? "Subject is required"
                                      : null;
                                });
                              },
                              errorText: subjectErrorttext,
//validator: (value) {},
                            ),
                            height(20),
                            const Text(
                              "Explain in Brief",
                              style: TextView.text60015black,
                            ),
                            height(14),
                            CustomField(
                              max: 10,
                              hint: "",
                              label: "",
                              controller: ReportIssue.brief,
                              suffixFunction: () {},
                              suffixIcon: const Text(""),
                              //validator: (value) {},
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  explainErrortext = value.isEmpty
                                      ? "Explain in brief is required"
                                      : null;
                                });
                              },
                              errorText: explainErrortext,
                            ),
                            height(45),
                            Buttons().solidButton(() {
                              if (ReportIssue.email.text.isEmpty ||
                                  ReportIssue.mobile.text.isEmpty ||
                                  ReportIssue.subject.text.isEmpty ||
                                  ReportIssue.brief.text.isEmpty) {
                                // Show a Snackbar if any field is empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please enter all the fields'),
                                  ),
                                );
                                return; // Exit the function if any field is empty
                              }
                              // Validate the mobile number
                              if (ReportIssue.mobile.text.isEmpty ||
                                  ReportIssue.mobile.text.length < 10) {
                                // Show a Snackbar if the mobile number is empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please enter a  valid Number'),
                                  ),
                                );
                                return; // Exit the function if the mobile number is empty
                              }
                              if (ReportIssue.email.text.isEmpty) {
                                // Show a Snackbar if the email is empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please enter an email address'),
                                  ),
                                );
                                return; // Exit the function if the email is empty
                              }

                              // If the email address is valid, proceed with the form submission
                              if (ReportIssue.email.text.isNotEmpty) {
                                // Validate the email using a regular expression
                                final RegExp emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                );
                                if (!emailRegex
                                    .hasMatch(ReportIssue.email.text)) {
                                  // Show a Snackbar if the email is not in the correct format
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please enter a valid email address'),
                                    ),
                                  );
                                  return; // Exit the function if the email is not valid
                                }
                              }

                              // If the mobile number is valid, proceed with the form submission
                              reportIssue();
                              // Clear the text fields
                            }, "Submit"),
                          ])))
              : const Center(
                  child: CircularProgressIndicator(),
                )
          : widget.reportType == "Request a Callback"
              ? !loading
                  ? SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 28.0,
                          horizontal: 21,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
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
                                                color: const Color(0x80EEEEEE),
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                selectedDate
                                                    .toString()
                                                    .split(" ")[0],
                                                style: TextView
                                                    .text50011superLight
                                                    .copyWith(
                                                        color: Colors.black),
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
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Time",
                                        style: TextView.text60015black,
                                      ),
                                      height(13),
                                      InkWell(
                                        onTap: () {
                                          _showTimePicker();
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
                                                color: const Color(0x80EEEEEE),
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _selectedTime.format(context),
                                                style: TextView
                                                    .text50011superLight
                                                    .copyWith(
                                                        color: AppColors
                                                            .lightdark),
                                              ),
                                              const Icon(
                                                Icons.history_toggle_off,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            height(27),
                            const Text(
                              "Mobile Number",
                              style: TextView.text60015black,
                            ),
                            height(14),
                            CustomField(
                              hint: "",
                              label: "",
                              controller: AnoRep.place,
                              keyboardType: TextInputType.phone,
                              suffixFunction: () {},
                              suffixIcon: const Text(""),
                              maxLength: 10,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Mobile number is required';
                                } else if (value.length != 10) {
                                  return 'Mobile number must be 10 digits';
                                } else if (!RegExp(r'^[1-9][0-9]*$')
                                    .hasMatch(value)) {
                                  return 'Mobile number should start with a digit from 1 to 9';
                                }
                                return null; // Return null if the validation succeeds
                              },
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  mobiLEErrortext = value.isEmpty
                                      ? "Mobile Number is  required"
                                      : null;
                                });
                              },
                              errorText: mobiLEErrortext,
                            ),
                            height(20),
                            const Text(
                              "Subject",
                              style: TextView.text60015black,
                            ),
                            height(14),
                            CustomField(
                              hint: "",
                              label: "",
                              controller: AnoRep.subject,
                              suffixFunction: () {},
                              suffixIcon: const Text(""),
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  subjecTErrortext = value.isEmpty
                                      ? "Subject is required"
                                      : null;
                                });
                              },
                              errorText: subjecTErrortext,
                            ),
                            height(20),
                            const Text(
                              "Topic to speak about",
                              style: TextView.text60015black,
                            ),
                            height(14),
                            CustomField(
                              max: 10,
                              hint: "",
                              label: "",
                              controller: AnoRep.brief,
                              suffixFunction: () {},
                              suffixIcon: const Text(""),
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  topictospeakErrortext = value.isEmpty
                                      ? "Topic to speak about is required"
                                      : null;
                                });
                              },
                              errorText: topictospeakErrortext,
                            ),
                            height(45),
                            Buttons().solidButton(() {
                              callbackRequest();
                              // Check if any field is empty
                              if (AnoRep.place.text.isEmpty ||
                                  AnoRep.subject.text.isEmpty ||
                                  AnoRep.brief.text.isEmpty) {
                                // Show a Snackbar if any field is empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      "Report Submitted",
                                    ),
                                  ),
                                );
                                return; // Exit the function if any field is empty
                              }

                              // If all fields are filled, proceed with the callback request

                              // Clear the text fields after submission
                            }, "Submit")
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
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
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
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
                                                color: const Color(0x80EEEEEE),
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                selectedDate
                                                    .toString()
                                                    .split(" ")[0],
                                                style: TextView
                                                    .text50011superLight
                                                    .copyWith(
                                                        color: Colors.black),
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
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Time",
                                        style: TextView.text60015black,
                                      ),
                                      height(13),
                                      InkWell(
                                        onTap: () {
                                          _showTimePicker();
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
                                                color: const Color(0x80EEEEEE),
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _selectedTime.format(context),
                                                style: TextView
                                                    .text50011superLight
                                                    .copyWith(
                                                        color: AppColors
                                                            .lightdark),
                                              ),
                                              const Icon(
                                                Icons.history_toggle_off,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            height(27),
                            const Text(
                              "Place Of Incident",
                              style: TextView.text60015black,
                            ),
                            height(14),
                            CustomField(
                              hint: "",
                              label: "",
                              controller: AnoRep.place,
                              suffixFunction: () {},
                              suffixIcon: const Text(""),
                              // validator: (value) {},
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  placeErrortext = value.isEmpty
                                      ? "Palce of incident is required"
                                      : null;
                                });
                              },
                              errorText: placeErrortext,
                            ),
                            height(20),
                            const Text(
                              "Subject",
                              style: TextView.text60015black,
                            ),
                            height(14),
                            CustomField(
                              hint: "",
                              label: "",
                              controller: AnoRep.subject,
                              suffixFunction: () {},
                              suffixIcon: const Text(""),
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  sUbjectErrortext = value.isEmpty
                                      ? "Subject is required"
                                      : null;
                                });
                              },
                              errorText: sUbjectErrortext,
                            ),
                            height(20),
                            const Text(
                              "Explain in Brief",
                              style: TextView.text60015black,
                            ),
                            height(14),
                            CustomField(
                              max: 10,
                              hint: "",
                              label: "",
                              controller: AnoRep.brief,
                              suffixFunction: () {},
                              suffixIcon: const Text(""),
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  explaininErrortext = value.isEmpty
                                      ? "This Field is required"
                                      : null;
                                });
                              },
                              errorText: explaininErrortext,
                            ),
                            height(45),
                            Buttons().solidButton(() {
                              if (AnoRep.place.text.isEmpty ||
                                  AnoRep.subject.text.isEmpty ||
                                  AnoRep.brief.text.isEmpty) {
                                // Show a Snackbar if any field is empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please enter all the fields'),
                                  ),
                                );
                                return; // Exit the function if any field is empty
                              }

                              anoRepSubmit();
                              // If all fields are filled, proceed with form submission
                              // Clear the text fields
                              // AnoRep.subject.clear();
                              // AnoRep.place.clear();
                              // AnoRep.brief.clear();
                            }, "Submit"),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
    );
  }
}
