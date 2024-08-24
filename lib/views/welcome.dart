import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: Stack(
        children: [
       Image(
          image: AssetImage('assets/image.png'),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        ],
      ),
    );
  }
}