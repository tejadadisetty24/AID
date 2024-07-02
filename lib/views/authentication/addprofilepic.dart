import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/export.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class AddProfilePic extends StatefulWidget {
  const AddProfilePic({Key? key}) : super(key: key);

  @override
  State<AddProfilePic> createState() => _AddProfilePicState();
}

class _AddProfilePicState extends State<AddProfilePic> {
  // ignore: unused_field
  XFile? _pickedFile;
  // ignore: unused_field
  CroppedFile? _croppedFile;
  bool photoUploading = false;
  String initailValue = "0";
  String base64 = '';
  XFile? file;
  String error = "";
  File downloadUrl = File('');
  ImagePicker picker = ImagePicker();
  pickImageAndUploadToFireBase() async {
    file = await picker.pickImage(source: ImageSource.gallery);
    File? image = File(file!.path);
    File croppedImage = await _cropImage(imageFile: image);
    if (file != null) {
      setState(() {
        photoUploading = true;
        base64 = base64Encode(croppedImage.readAsBytesSync());
      });
//Sree@1996
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
            photoUploading = true;
            downloadUrl = croppedImage;
            initailValue = "100.0";
            sharedPrefs.setString('photo', base64);
          });
        } else {
          initailValue = "Failed To Upload";
        }
      } catch (e) {
        error = e.toString();
      }
    }
  }

  Future<File> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: imageFile.path, cropStyle: CropStyle.circle);
    if (croppedImage == null) return imageFile;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.black,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Add Profile  Photo",
              style: TextView.text60018black,
            ),
            !photoUploading
                ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      color: const Color.fromARGB(255, 255, 253, 253),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor
                              .withOpacity(0.7), // Box shadow color
                          spreadRadius: 5, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: const Offset(0, 2), // Offset of shadow
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.photo_camera,
                                size: 28,
                                color: AppColors.iconColor,
                              ),
                              height(2.77),
                              const Text(
                                "Add Profile Photo",
                                style: TextView.text60018black,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -30,
                          left: 65,
                          child: InkWell(
                            onTap: () {
                              pickImageAndUploadToFireBase();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(
                                  70,
                                ),
                                color: AppColors.primaryColor,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      boxShadow: initailValue != "100.0"
                          ? null
                          : [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                      color: const Color.fromARGB(255, 255, 252, 252),
                    ),
                    child: initailValue != "100.0"
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SpinKitDancingSquare(
                                color: AppColors.primaryColor,
                              ),
                              height(1),
                              error != "" ? Text(error) : Text(initailValue),
                            ],
                          )
                        : downloadUrl.path != ""
                            ? ClipOval(
                                child: Image.file(
                                  downloadUrl,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : const SpinKitDancingSquare(
                                color: AppColors.primaryColor,
                              ),
                    //  const Icon(
                    //     Icons.done,
                    //     color: AppColors.primaryColor,
                    //     size: 150,
                    //   ),
                  ),
            Buttons().solidButton(
              () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainSreen(),
                    ),
                    (route) => false);
              },
              "Done",
            ),
          ],
        ),
      ),
    );
  }
}
