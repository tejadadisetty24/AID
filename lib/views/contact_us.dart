import 'package:sos/export.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
          "Contact Us",
          style: TextView.text70010Black.copyWith(
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 52,
          vertical: 58,
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Call Us",
                  style: TextView.text60015black,
                ),
                Icon(
                  Icons.phone_rounded,
                  color: AppColors.primaryColor,
                )
              ],
            ),
            height(50),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mail Us",
                  style: TextView.text60015black,
                ),
                Icon(
                  Icons.message,
                  color: AppColors.primaryColor,
                )
              ],
            ),
            height(50),
            const Text(
              "Follow us on Social media:",
              style: TextView.text60015black,
            ),
            height(37),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  Images.insta,
                  width: 48,
                  height: 51,
                ),
                Image.asset(
                  Images.fb,
                  width: 48,
                  height: 51,
                ),
                Image.asset(
                  Images.twitter,
                  width: 48,
                  height: 51,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
