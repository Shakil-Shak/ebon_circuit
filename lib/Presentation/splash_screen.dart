import 'dart:async';

import 'package:ebon_circuit/demo_for_today.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const DemoForToday();
          },
        ));
      },
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/splash_background.jpg"),
          Image.asset("assets/images/bs_logo.png"),
        ],
      ),
    );
  }
}
