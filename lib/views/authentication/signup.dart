// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/export.dart';
import 'package:flutter/material.dart';
import 'package:avoid_keyboard/avoid_keyboard.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? firstNameErrorText;
  String? lastNameErrorText;
  String? phonenumberErrorText;
  String? alternatephonenumberErrorText;
  String? emailErrorText;
  String? addressErrorText;
  String? cityErrorText;
  String? pincodeErrorText;
  String? passwordErrorText;
  String? confirmpasswordErrorText;
  bool checkBoxValue = false;

  @override
  void initState() {
    super.initState();
  }

  bool showPassword = false;
  bool showCfrmPassword = false;
  String dropdownvalue = "--Select--";
  var bloodGroups = [
    "--Select--",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "Don't know?"
  ];
  bool loading = false;
  String selectedState = '--Select State--';
  DateTime selectedDate = DateTime.now(); // Stores the selected date of birth
  int age = 0; // Stores the calculated age

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the initial date to the current date
      firstDate: DateTime(1900), // Set the minimum selectable date
      lastDate: DateTime.now(), // Set the maximum selectable date
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        age = _calculateAge(pickedDate);
        TxtCtrl.age.text = age.toString();
      });
    }
  }

  int _calculateAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  String gender = "--Select--";
  var genders = [
    "--Select--",
    "Male",
    "Female",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    return !loading
        ? Scaffold(
          resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              toolbarHeight: 104,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              centerTitle: true,
              title: const Text(
                "Create your Account",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black, // Set the text color
                ),
              ),
            ),
            body: AvoidKeyboard(
              spacing: 40,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: FocusTraversalGroup(
                      policy: OrderedTraversalPolicy(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(height: 32),
                              Text(
                                "Personal Details",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(1),
                            child: Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: CustomField(
                                    controller: TxtCtrl.firstName,
                                    hint: "",
                                    label: "First Name",
                                    suffixFunction: () {},
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Enter Your First Name';
                                      }
                                      return null;
                                    },
                                    errorText: firstNameErrorText,
                                    onChanged: (value) {
                                      setState(() {
                                        // Update error text dynamically based on text field content
                                        firstNameErrorText = value.isEmpty
                                            ? "First Name is required"
                                            : null;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 22.97),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: CustomField(
                                    controller: TxtCtrl.lastName,
                                    hint: "",
                                    label: "Last Name",
                                    suffixFunction: () {},
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Enter Your Last Name';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        // Update error text dynamically based on text field content
                                        lastNameErrorText = value.isEmpty
                                            ? "Last Name is required"
                                            : null;
                                      });
                                    },
                                    errorText: lastNameErrorText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.call),
                              SizedBox(height: 12),
                              Text(
                                "Contact Details",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(2),
                            child: Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: CustomField(maxLength: 10,
                                    controller: TxtCtrl.mobile,
                                    hint: "",
                                    label: "Phone Number",
                                    keyboardType: TextInputType.phone,
                                    suffixFunction: () {},
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
                                        phonenumberErrorText = value.isEmpty
                                            ? "Phone Number is required"
                                            : null;
                                      });
                                    },
                                    errorText: phonenumberErrorText,
                                  ),
                                ),
                                const SizedBox(width: 22.97),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: CustomField(
                                    maxLength: 10,
                                    controller: TxtCtrl.altNumber,
                                    hint: "",
                                    label: "Alternate Number",
                                    keyboardType: TextInputType.phone,
                                    suffixFunction: () {},
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Enter Alternate Mobile Number';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        // Update error text dynamically based on text field content
                                        alternatephonenumberErrorText = value.isEmpty
                                            ? "Alternate Phone Number is required"
                                            : null;
                                      });
                                    },
                                    errorText: alternatephonenumberErrorText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(3),
                            child: Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: CustomField(
                                    controller: TxtCtrl.email,
                                    hint: "",
                                    label: "Email",
                                    suffixFunction: () {},
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
                                        emailErrorText = value.isEmpty
                                            ? "Email is required"
                                            : null;
                                      });
                                    },
                                    errorText: emailErrorText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Blood Group",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          CustomDropdown(
                            value: dropdownvalue,
                            items: bloodGroups,
                            onChanged: (value) {
                              setState(() {
                                dropdownvalue = value!;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.calendar_month),
                              SizedBox(height: 13),
                              Text(
                                "Date of Birth",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 13),
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(4),
                            child: Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: InkWell(
                                    onTap: () => _showDatePicker(context),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        // labelText: 'Date of Birth',
                                        border: OutlineInputBorder(),
                                      ),
                                      child: Text(
                                        selectedDate.toString().split(' ')[0],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                age != 0
                                    ? Flexible(
                                        fit: FlexFit.loose,
                                        child: InputDecorator(
                                          decoration: const InputDecoration(
                                            labelText: 'Age',
                                            border: OutlineInputBorder(),
                                          ),
                                          child: Text(
                                            age.toString(),
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Gender",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: CustomDropdown(
                              value: gender,
                              items: genders,
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Address",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(2),
                            child: CustomField(
                              controller: TxtCtrl.address,
                              hint: "",
                              label: "",
                              suffixFunction: () {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Your Address';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  addressErrorText =
                                      value.isEmpty ? "address is required" : null;
                                });
                              },
                              errorText: addressErrorText,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: CustomDropdown(
                              value: selectedState,
                              items:
                                  indianStates, // Assuming you have this list defined somewhere
                              onChanged: (value) {
                                setState(() {
                                  selectedState = value!;
                                });
                              },
                            ),
                          ),
                          height(12),
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(7),
                            child: Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: CustomField(
                                    controller: TxtCtrl.city,
                                    hint: "",
                                    label: "City",
                                    suffixFunction: () {},
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Your City';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        // Update error text dynamically based on text field content
                                        cityErrorText =
                                            value.isEmpty ? "City is required" : null;
                                      });
                                    },
                                    errorText: cityErrorText,
                                  ),
                                ),
                                width(12),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: CustomField(maxLength: 6,
                                    keyboardType: TextInputType.phone,
                                    controller: TxtCtrl.pin,
                                    hint: "",
                                    label: "Pin Code",
                                    suffixFunction: () {},
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Your Pin Code';
                                      }
                                      return null;
                                    },
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
                                )
                              ],
                            ),
                          ),
                          height(12),
                          const Text(
                            "Password",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(8),
                            child: CustomField(
                              controller: TxtCtrl.password,
                              hint: "",
                              label: "Password",
                              isPassword: !showPassword,
                              suffixFunction: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              suffixIcon: !showPassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Your Password';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  passwordErrorText =
                                      value.isEmpty ? "password is required" : null;
                                });
                              },
                              errorText: passwordErrorText,
                            ),
                          ),
                          const SizedBox(height: 12),
                          FocusTraversalOrder(
                            order: const NumericFocusOrder(9),
                            child: CustomField(
                              controller: TxtCtrl.cfrmpwd,
                              hint: "",
                              label: "Confirm Password",
                              isPassword: !showCfrmPassword,
                              suffixFunction: () {
                                setState(() {
                                  showCfrmPassword = !showCfrmPassword;
                                });
                              },
                              suffixIcon: !showCfrmPassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Confirm Password';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  // Update error text dynamically based on text field content
                                  confirmpasswordErrorText = value.isEmpty
                                      ? "confirm password is required"
                                      : null;
                                });
                              },
                              errorText: confirmpasswordErrorText,
                            ),
                          ),
                          height(12),
                          const Text(
                            "Emergency Contacts",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                openEmergencyBottomSheet(
                                    context,
                                    TxtCtrl.emergencyName1,
                                    TxtCtrl.emergencyPhone1,
                                    TxtCtrl.emergencyRelation1);
                              },
                              child: const Text("Emergency Contact 1"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                openEmergencyBottomSheet(
                                    context,
                                    TxtCtrl.emergencyName2,
                                    TxtCtrl.emergencyPhone2,
                                    TxtCtrl.emergencyRelation2);
                              },
                              child: const Text("Emergency Contact 2"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                openEmergencyBottomSheet(
                                    context,
                                    TxtCtrl.emergencyName3,
                                    TxtCtrl.emergencyPhone3,
                                    TxtCtrl.emergencyRelation3);
                              },
                              child: const Text("Emergency Contact 3"),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(
                                value: checkBoxValue,
                                onChanged: (newValue) {
                                  // checkBoxValue = newValue!;
                                    
                                  _showTermsAndConditionsPopup();
                                },
                              ),
                              const Text("I agree to T&C's  and Privacy Policy"),
                            ],
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (!checkBoxValue) {
                                  // Show a Snackbar if the checkbox is not checked
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please accept the Terms & Conditions.'),
                                    ),
                                  );
                                } else {
                                  // Proceed with registration if the checkbox is checked
                                  signUp();
                                  // TxtCtrl.firstName.clear();
                                  // TxtCtrl.lastName.clear();
                                  // TxtCtrl.mobile.clear();
                                  // TxtCtrl.email.clear();
                                  // TxtCtrl.password.clear();
                                  // TxtCtrl.city.clear();
                                  // TxtCtrl.emergencyName1.clear();
                                  // TxtCtrl.emergencyRelation1.clear();
                                  // TxtCtrl.emergencyPhone1.clear();
                                  // TxtCtrl.emergencyName2.clear();
                                  // TxtCtrl.emergencyRelation2.clear();
                                  // TxtCtrl.emergencyPhone2.clear();
                                  // TxtCtrl.emergencyName3.clear();
                                  // TxtCtrl.emergencyRelation3.clear();
                                  // TxtCtrl.emergencyPhone3.clear();
                                  // TxtCtrl.altNumber.clear();
                                  // TxtCtrl.pin.clear();
                                  // TxtCtrl.cfrmpwd.clear();
                                }
                              },
                              child: const Text("Register"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  void _showTermsAndConditionsPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
// Variable to hold terms and conditions text

        return AlertDialog(
          title: const Text(
            '',
          ),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Terms & Conditions :",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '''Terms and Conditions for AID Mobile Application:


1. Introduction
Welcome to AID, a non-profit organisation dedicated to aiding individuals in medical and violation emergencies through community support and government coordination. These Terms and Conditions govern your use of the AID mobile application and any services provided therein.

2. Acceptance of Terms
By accessing or using the AID mobile application, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you may not access or use the AID application.

3. Use of the AID Application
a. The AID application is intended solely for the purpose of aiding individuals in medical and violation emergencies by providing their contact details to nearby individuals and government officials.
b. You agree to use the AID application only for lawful purposes and in accordance with these Terms and Conditions.
c. You acknowledge that AID does not guarantee the availability of assistance or response in any given emergency situation.

4. Privacy:
a. AID collects and stores personal information provided by users for the purpose of facilitating emergency assistance, blood-related services, and aid in cyber cases.
b. AID does not guarantee the security of user data and is not responsible for any breaches of privacy or unauthorised access to user information.
c. By using the AID application, you consent to the collection, storage, and use of your personal information in accordance with our Privacy Policy.

5. Limitation of Liability:
a. AID is not liable for any damages, including but not limited to direct, indirect, incidental, consequential, or punitive damages, arising out of or in connection with the use or inability to use the AID application.
b. AID is not responsible for the actions or conduct of individuals who respond to emergency requests, blood donation requests, or cyber cases through the AID application.
c. AID does not guarantee the availability of blood, successful resolution of cyber cases, or the accuracy, completeness, or reliability of information provided by users, medical personnel, or government officials through the application.6. Blood Group Certification and Medical Label QR Scanner
d. AID is dedicated to certifying each and every person with a blood group certificate for facilitating swift response during medical emergencies.
e. Additionally, AID strives to provide a medical label feature within the application, displaying essential details such as blood group, name, emergency contacts, height, weight, etc., to aid medical responders in providing timely assistance.

6. Indemnification
You agree to indemnify and hold harmless AID, its officers, directors, employees, agents, and affiliates from and against any and all claims, liabilities, damages, losses, or expenses, including reasonable attorneys' fees and costs, arising out of or in any way connected with your use of the AID application.

7. Modifications to Terms
AID reserves the right to modify or update these Terms and Conditions at any time without prior notice. Your continued use of the AID application after any such changes constitutes acceptance of the updated Terms and Conditions.

8. Governing Law
These Terms and Conditions shall be governed by and construed in accordance with the laws of [Jurisdiction], without regard to its conflict of law provisions.

9. Third-Party Links:
The Aid App may contain links to third-party websites or services that are not owned or controlled by us. We are not responsible for the content, privacy policies, or practices of any third-party websites or services. Users access third-party links at their own risk.

10. Force Majeure:
The Aid App shall not be liable for any failure or delay in performance resulting from causes beyond its reasonable control, including but not limited to natural disasters, acts of war, or governmental restrictions.

11. Entire Agreement:
These terms and conditions constitute the entire agreement between the user and the Aid App, superseding any prior agreements or understandings, whether oral or written, regarding the subject matter herein.

By using the AID mobile application, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.''',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                SizedBox(height: 10),
                Text(
                  "Privacy Policy:",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('''Privacy Policy for AID Mobile Application:

1. Introduction:
Welcome to the Privacy Policy for the AID mobile application, operated by AID, a non-profit organization dedicated to aiding individuals in medical and violation emergencies through community support, government coordination, assistance with blood-related services, aid in cyber cases, and other related services. This Privacy Policy outlines how we collect, use, disclose, and safeguard your personal information when you use our mobile application.

2. Information We Collect:
a. **Personal Information:** When you use the AID application, we may collect personal information such as your name, contact details, location, emergency contact information, and any other information you voluntarily provide.
b. **Usage Data:** We may also collect information about how you use the AID application, including your interactions with the app and the services provided therein.

3. Use of Information:

a. We use the personal information collected to facilitate emergency assistance, blood-related services, aid in cyber cases, and other related services offered through the AID application.
b. We may also use your information to improve the AID application, analyze usage trends, personalize your experience, and communicate with you about updates or important information.
c. We do not sell, rent, or trade your personal information to third parties for marketing purposes.

4. Data Security:
a. We implement reasonable security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction.
b. However, please note that no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.

5. Data Retention:
We will retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law.

6. Third-Party Links:
The AID application may contain links to third-party websites or services. We are not responsible for the privacy practices or content of such third parties. We encourage you to review the privacy policies of any third-party websites or services that you visit.

7. Children's Privacy:
The AID application is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us so that we can delete the information.

8. Changes to this Privacy Policy:
We reserve the right to update or modify this Privacy Policy at any time. If we make any material changes, we will notify you by email or by posting the updated Privacy Policy on the AID application. Your continued use of the AID application after any such changes constitutes acceptance of the updated Privacy Policy.
By using the AID mobile application, you acknowledge that you have read, understood, and agree to be bound by this Privacy Policy.
''')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  checkBoxValue = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  checkBoxValue = true;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Agree'),
            ),
          ],
        );
      },
    );
  }

  Future<void> errorDialog(
    String text,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error in form'),
          content: SingleChildScrollView(
            child: Center(
              child: Text(text),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  signUp() async {
    if (TxtCtrl.password.text != TxtCtrl.cfrmpwd.text) {
      errorDialog("Password mismatch");
    } else if (gender == "--Select--") {
      errorDialog("Select Gender");
    } else if (!RegExp(r'^[1-9][0-9]*$').hasMatch(TxtCtrl.mobile.text)) {
      errorDialog("Enter Correct Mobile Number");
    } else if (selectedState == "--Select State--") {
      errorDialog("Select State");
    } else if (dropdownvalue == "--Select--") {
      errorDialog("Select Blood Group");
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(TxtCtrl.email.text)) {
      errorDialog("Enter Correct email");
    } else if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(TxtCtrl.mobile.text)) {
      errorDialog("Enter proper mobile number");
    } else if (age == 0 || age < 10) {
      errorDialog("Age cannot be less than 10");
    } else {
      final prefs = await SharedPreferences.getInstance();
      try {
        setState(() {
          loading = true;
        });
        var reqbody = jsonEncode({
          "firstName": TxtCtrl.firstName.text,
          "lastName": TxtCtrl.lastName.text,
          "mobileNumber": TxtCtrl.mobile.text,
          "email": TxtCtrl.email.text,
          "password": TxtCtrl.password.text,
          "dateOfBirth": selectedDate.toIso8601String().split("T")[0],
          "age": "$age",
          "gender": gender,
          "bloodGroup": dropdownvalue,
          "address": TxtCtrl.city.text,
          "emergencyContact1": {
            "name": TxtCtrl.emergencyName1.text,
            "relation": TxtCtrl.emergencyRelation1.text,
            "mobileNumber": TxtCtrl.emergencyPhone1.text
          },
          "emergencyContact2": {
            "name": TxtCtrl.emergencyName2.text,
            "relation": TxtCtrl.emergencyRelation2.text,
            "mobileNumber": TxtCtrl.emergencyPhone2.text
          },
          "emergencyContact3": {
            "name": TxtCtrl.emergencyName3.text,
            "relation": TxtCtrl.emergencyRelation3.text,
            "mobileNumber": TxtCtrl.emergencyPhone3.text
          },
          "alternateNumber": TxtCtrl.altNumber.text,
          "pincode": TxtCtrl.pin.text,
          "confirmPassword": TxtCtrl.cfrmpwd.text,
          "coordinatesLatitude": latitude,
          "coordinatesLongitude": longitute
        });
        var res = await http.post(Uri.parse('${baseUrl}signup'),
            headers: {"content-type": 'application/json'}, body: reqbody);

        if (res.statusCode == 200) {
          var body = json.decode(res.body);
          setState(() {
            loading = false;
            prefs.setString('firstName', body['user']['firstName']);
            prefs.setString('lastName', body['user']['lastName']);
            prefs.setString('mobile', body['user']['mobileNumber']);
            prefs.setString('altNumber', body['user']['alternateNumber']);
            prefs.setString('email', body['user']['email']);
            prefs.setString('address', body['user']['address']);
            prefs.setString('pin', body['user']['pincode']);
            prefs.setString('DOB', body['user']['dateOfBirth']);
            prefs.setString('age', body['user']['age']);
            prefs.setString('gender', body['user']['gender']);
            prefs.setString('bloodGroup', body['user']['bloodGroup']);
            prefs.setString('latitude', body['user']['coordinatesLatitude']);
            prefs.setString('longitude', body['user']['coordinatesLongitude']);
            prefs.setString('userId', body['user']['userId']);
            if (body['user']['photo'] != null) {
              prefs.setString('photo',body['user']['photo'] );
            }
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProfilePic()));
        } else {
          setState(() {
            loading = false;
          });
        }
      } catch (e) {
        errorDialog(e.toString());
      }
    }
  }
}

void openEmergencyBottomSheet(BuildContext context, TextEditingController ctrl1,
    TextEditingController ctrl2, TextEditingController ctrl3) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, bottom: 80),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: FocusTraversalGroup(

            policy: OrderedTraversalPolicy(secondary: WidgetOrderTraversalPolicy()),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: M,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FocusTraversalOrder(order: const NumericFocusOrder(1),
                  child: TextField(
                    controller: ctrl1,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
                const SizedBox(height: 12),
                FocusTraversalOrder(order: const NumericFocusOrder(1),
                  child: TextField(
                    maxLength: 10,
                    controller: ctrl2,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(height: 12),
                FocusTraversalOrder(order: const NumericFocusOrder(3),
              
                  child: TextField(
                    controller: ctrl3,
                    decoration: const InputDecoration(labelText: 'Relationship'),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class CustomDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}
