import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sos/views/splash_screen.dart';

import '../../utils/delayedWidgets.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (builder) => const SplashScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow, // Set background color to yellow
      appBar: AppBar(
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 200,
            ),
            Animate(
                child: const Text(
              "AID",
              style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 3,
                    ),
                  ],
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  fontSize: 80),
              textAlign: TextAlign.center,
            ).animate().fade(duration: 2.seconds)),
            // Animate(

            //     child: Text(
            //   "Assistance in Immediate Disaster",
            //   style: TextStyle(
            //       shadows: [
            //         Shadow(
            //           color: Colors.black,
            //           offset: Offset(1, 1),
            //           blurRadius: 2,
            //         ),
            //       ],
            //       color: Colors.white,
            //       fontFamily: 'Poppins',
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20),
            //   textAlign: TextAlign.center,
            // ).animate().fade(duration: 4.seconds).slideX())
            DelayedWidget(
              delayDuration: const Duration(seconds: 2),
              child: AnimatedTextKit(animatedTexts: [
                TyperAnimatedText('Assistance in Immediate Disasters',
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          )
                        ])),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
