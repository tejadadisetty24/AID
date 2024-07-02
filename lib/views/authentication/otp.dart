import 'package:flutter/material.dart';
import 'package:sos/export.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTP extends StatefulWidget {
  final String text;
  const OTP({Key? key, required this.text}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              height(MediaQuery.of(context).padding.top),
              Container(
                margin: const EdgeInsets.only(bottom: 68),
                height: 187,
                //width: 280,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "AID",
                        style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  offset: Offset(5, 5),
                                  blurRadius: 15),
                            ]),
                      ),
                      Text(
                        "Association for inviolation and dire",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              height(14),
              const Text(
                "OTP VERIFICATION",
                style: TextView.text50018black,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Enter the OTP sent to - ",
                      style: TextView.text40014black,
                    ),
                    TextSpan(
                      text: widget.text,
                      style: TextView.text40014black.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              height(38),
              PinCodeTextField(
                appContext: context,
                length: 4,
                onChanged: (value) {},
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  selectedColor: Colors.blue,
                ),
              ),
              height(27),
              Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Text(
                  "00:12 Sec",
                  style: TextView.text50018black.copyWith(
                    fontSize: 14,
                    color: AppColors.otptimer,
                  ),
                ),
              ),
              height(22),
              Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Don’t receive code ? ",
                        style: TextView.text40014black,
                      ),
                      TextSpan(
                        text: "Resend OTP",
                        style: TextView.text40014black.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              height(58),
              Buttons().solidButton(
                  () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddProfilePic(),
                          ),
                        ),
                      },
                  "Submit"),
            ],
          ),
        ),
      ),
    );
  }
}
