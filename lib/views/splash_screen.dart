// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'package:sos/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sos/views/authentication/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var data;
  var imageUrl;
  bool loading = false;

  Future<dynamic> getData() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String? userId = sharedPrefs.getString('userId');
    if (userId != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainSreen()));
    } else {
      return;
    }
  }

  late BuildContext ctx;

  @override
  void initState() {
    getData();
    ctx = context;
    if (!locstatus) {
      showMyDialog(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        color: AppColors.dullBg,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
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
                        "Assistance in Immediate Disasters",
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
              loading
                  ? Container()
                  : const Text(
                      'Raise your Voice',
                      style: TextStyle(
                          color: AppColors.black, fontWeight: FontWeight.w700),
                    ),
              loading
                  ? const SpinKitCircle(
                      color: AppColors.primaryColor,
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 80),
                      child: const Text(
                        'ONE FOR ALL, ALL FOR ONE',
                        style: TextStyle(fontSize: 18, fontFamily: 'Poppin'),
                      ),
                    ),
              // height(100),
              loading
                  ? Container()
                  : FloatingActionButton(
                      onPressed: () {
                        // if ( != null) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const MainSreen()));
                        // } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      backgroundColor: AppColors.black,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
