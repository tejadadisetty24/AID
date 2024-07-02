import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sos/export.dart';
import 'package:sos/services/login.dart';
import 'package:sos/views/authentication/forget_password.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Buttons btn = Buttons();
  @override
  void initState() {
    super.initState();
  }

  bool passwordvisible = true;
  bool isLoading = false; // Flag to track login process

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  height(MediaQuery.of(context).padding.top),
                  Container(
                    margin: const EdgeInsets.only(bottom: 68),
                    height: 187,
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
                  height(0),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  height(11),
                  const Text(
                    "Please enter your account details",
                    style: TextStyle(
                        color: AppColors.lightgrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  height(38),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFEEEEEE),
                      ),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    height: 60,
                    child: TextField(
                      controller: Login.email,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Email or Phone number",
                        prefixIcon: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 17),
                          child: const FaIcon(
                            FontAwesomeIcons.envelope,
                            color: Colors.black,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 24,
                        ),
                      ),
                    ),
                  ),
                  height(20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFEEEEEE),
                      ),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    height: 60,
                    child: TextField(
                      obscureText: passwordvisible,
                      obscuringCharacter: "*",
                      controller: Login.password,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        prefixIcon: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 17),
                          child: const FaIcon(
                            FontAwesomeIcons.lock,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Password",
                        suffixIcon: passwordvisible
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    passwordvisible = false;
                                  });
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 17),
                                    child: const FaIcon(FontAwesomeIcons.eye)))
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    passwordvisible = true;
                                  });
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 17),
                                    child: const FaIcon(
                                        FontAwesomeIcons.eyeSlash))),
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 24,
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 24,
                        ),
                      ),
                    ),
                  ),
                  height(20),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF797786),
                        ),
                      ),
                    ),
                  ),
                  height(20),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (Login.email.text.isNotEmpty &&
                                Login.password.text.isNotEmpty) {
                             CustomerLogin().login(Login.email.text, Login.password.text, context);
                            } else {
                              // Handle case where email or password is empty
                              // Show a snackbar or some other UI indication
                            }
                          },
                    child: const Text("Login"),
                  ),
                  height(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                text: 'New user?  ',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey)),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const SignUp()));
                                  },
                                text: 'Create Account',
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.primaryColor))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
