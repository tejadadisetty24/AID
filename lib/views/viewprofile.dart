// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/export.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;

// Define a class to represent user profile details

// Create a StatefulWidget for the ViewProfile screen
class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

// Create the state for the ViewProfile screen
class _ViewProfileState extends State<ViewProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController alternativeNumberController = TextEditingController();

// Variable to store the selected image
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
  String base = '';
  String bloodGroup = '';
  String userId = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Load user data into controllers
  loadData() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    nameController.text =
        "${sharedPrefs.getString("firstName")} ${sharedPrefs.getString("lastName")}";
    firstNameController.text = "${sharedPrefs.getString("firstName")} ";
    lastNameController.text = "${sharedPrefs.getString("lastName")} ";
    ageController.text = "${sharedPrefs.getString("age")} ";
    addressController.text = "${sharedPrefs.getString("address")} ";
    mobileController.text = "${sharedPrefs.getString("mobile")} ";
    emailController.text = "${sharedPrefs.getString("email")} ";
    pincode.text = "${sharedPrefs.getString("pincode")} ";
    alternativeNumberController.text = "${sharedPrefs.getString("altNumber")} ";
    setState(() {
      base = sharedPrefs.getString('photo')!;
      bloodGroup = sharedPrefs.getString('bloodGroup')!;
      userId = sharedPrefs.getString('userId')!;
    });
  }

  // Build the UI for the ViewProfile screen
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            child: Column(
              children: [
                // Back button

                // User profile image
                // User profile image
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular avatar with a loader
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: ClipOval(
                        child: Container(
                          color: Colors.grey[200],
                          child: !loading
                              ? Image.memory(
                                  base64Decode(base),
                                  fit: BoxFit.cover,
                                  width: 160,
                                  height: 160,
                                )
                              : const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    // Edit icon at bottom right of the image
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          showEditImageBottomSheet(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          height(20),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 51, horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User details - Name and Age
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Age",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    height(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(nameController.text),
                        Text(ageController.text),
                      ],
                    ),
                    height(40),
                    // User details - Address
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Pincode",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    height(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(addressController.text),
                        Text(pincode.text),
                      ],
                    ),
                    height(40),
                    // User details - Blood Group and Mobile
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Blood Group",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Mobile",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(bloodGroup),
                        Text(mobileController.text),
                      ],
                    ),
                    height(40),
                    // User details - Email and Alternative Number
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Alternative Number",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(emailController.text),
                        Text(alternativeNumberController.text),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Edit Profile button
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          showEditProfileBottomSheet(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => editProfile()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: const Text("Edit Profile"),
                      ),
                    ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // Container(
                    //   alignment: Alignment.bottomCenter,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       // Navigate to the new page here
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => changepassword()),
                    //       );
                    //     },
                    //     child: const Text("Change Password"),
                    //   ),
                    // ),

                    const SizedBox(height: 60),
                    // Version information
                    Container(
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        "Version - 1.0.6798",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showEditImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a Photo'),
              onTap: () {
                _getImageFromCamera();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                _getImageFromGallery();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  String initailValue = '';

  // Method to capture an image using the device camera
  void _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File img = File(pickedFile.path);
      uploadImageToStorage(img);
      // You can implement logic to upload the image to a server or Firebase Storage
    }
  }


  // Method to choose an image from the device gallery
  void _getImageFromGallery() async {
    // ignore: await_only_futures

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    File? image = File(pickedFile!.path);

    uploadImageToStorage(image);
  }

  Future<File> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: imageFile.path, cropStyle: CropStyle.circle);
    if (croppedImage == null) return imageFile;
    return File(croppedImage.path);
  }

  // Show the bottom sheet to edit user profile details
  void showEditProfileBottomSheet(BuildContext context) {
    // Create a ScrollController
    ScrollController scrollController = ScrollController();

    // Function to scroll to the selected text field
    void scrollToSelectedTextField() {
      // Ensure that the scroll controller has been attached to a view before scrolling
      if (scrollController.hasClients) {
        // Scroll to the position of the selected text field
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          controller: scrollController, // Assign the ScrollController
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: scrollController, // Assign the ScrollController
                  children: [
                    // Build editable fields for user details
                    buildEditableField(
                      "First Name",
                      firstNameController,
                      onTap:
                          scrollToSelectedTextField, // Call the function when tapped
                    ),
                    buildEditableField(
                      "Last Name",
                      lastNameController,
                      onTap: scrollToSelectedTextField,
                    ),
                    buildEditableField(
                      "Age",
                      ageController,
                      onTap: scrollToSelectedTextField,
                    ),
                    buildEditableField(
                      "Address",
                      addressController,
                      onTap: scrollToSelectedTextField,
                    ),
                    buildEditableField(
                      "Pincode",
                      pincode,
                      onTap: scrollToSelectedTextField,
                    ),
                    buildEditableField(
                      "Mobile",
                      mobileController,
                      onTap: scrollToSelectedTextField,
                    ),
                    buildEditableField(
                      "Email",
                      emailController,
                      onTap: scrollToSelectedTextField,
                    ),
                    buildEditableField(
                      "Alternative Number",
                      alternativeNumberController,
                      onTap: scrollToSelectedTextField,
                    ),
                    // Save button
                    ElevatedButton(
                      onPressed: () {
                        // Implement logic to save the edited profile
                        saveprofile();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: const Text("Save"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method to save the edited profile details
  saveprofile() async {
    var prefs = await SharedPreferences.getInstance();
    var data = {
      "address": addressController.text,
      'age': ageController.text,
      "alternateNumber": alternativeNumberController.text,
      "email": emailController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "mobileNumber": mobileController.text,
      "pincode": pincode.text,
    };
    var res = await http.put(Uri.parse('${baseUrl}users'),
        body: jsonEncode(data),
        headers: {"content-type": 'application/json', "userId": userId});
    if (res.statusCode == 200) {
      setState(() {
        loading = false;
        prefs.setString('firstName', firstNameController.text);
        prefs.setString('lastName', lastNameController.text);
        prefs.setString('mobile', mobileController.text);
        prefs.setString('altNumber', alternativeNumberController.text);
        prefs.setString('email', emailController.text);
        prefs.setString('address', addressController.text);
        prefs.setString('pincode', pincode.text);
        prefs.setString('age', ageController.text);
        loadData();
      });
      Navigator.pop(context);
    } else {}
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    File croppedImage = await _cropImage(imageFile: imageFile);
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      var req =
          http.MultipartRequest("POST", Uri.parse("${baseUrl}upload-photo"));
      req.files
          .add(await http.MultipartFile.fromPath("photo", croppedImage.path));
      req.headers.addAll({"userId": sharedPrefs.getString("userId")!});
      var res = await req.send();
      if (res.statusCode == 200) {
        setState(() {
          base = base64Encode(croppedImage.readAsBytesSync());
          sharedPrefs.setString('photo', base);
        });
      }
      return base64Encode(croppedImage.readAsBytesSync());
    } catch (e) {
      return "";
    }
  }
}

// Build editable text fields for user details
typedef VoidCallback = void Function();
Widget buildEditableField(String label, TextEditingController controller,
    {VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      onTap: onTap,
    ),
  );
}
