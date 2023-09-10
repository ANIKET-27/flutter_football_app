import 'dart:async';

import 'package:all_league_football_app/Views/home.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  mover() async {
    Timer(const Duration(seconds: 5), () {
       Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => HomePage()));
    });
   
  }

  @override
  void initState() {
    // TODO: implement initState

    mover();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
          'https://lottie.host/?file=242e8398-4a30-4601-ad80-4c4eb946a879/IxbzCafDUf.json',
          errorBuilder: (context, exception, stackTrace) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
