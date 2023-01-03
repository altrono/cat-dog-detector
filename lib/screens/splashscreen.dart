import 'package:cat_dog_detector/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: HomeScreen(),
      title: const Text(
        'Dog a Cat',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Color(
              0xFFFFB100,
          )
        ),
      ),
      image: Image.asset('assets/catdog.png'),
      backgroundColor: Color(0xaa000000),
      loaderColor: Color(0xFFA3BB98),
      photoSize: 100.0,
    );
  }
}
