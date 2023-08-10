// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<String> backgroundImages = [
    'assets/bg1.jpg',
    'assets/bg2.jpg',
    'assets/bg3.jpg',
    'assets/bg4.jpg',
  ];

  String selectedImage = '';
  @override
  void initState() {
    super.initState();
    selectedImage = backgroundImages[Random().nextInt(backgroundImages.length)];
    // Simulate some initialization process or delay (e.g., fetching data).
    // After that, navigate to the home screen or the main screen of your app.
    // You can replace the `Future.delayed` with your actual initialization code.
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/home'); // Replace '/home' with your desired route.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Customize your splash screen UI here.
    return Scaffold(
      backgroundColor: Colors.transparent, // Set the background color.
      body: Container(
        width: MediaQuery.of(context).size.width, // Get screen width.
        height: MediaQuery.of(context).size.height, // Get screen height.
        decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage(selectedImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 284, // Set the desired width of the logo.
                height: 62, // Set the desired height of the logo.
              ),
              const SizedBox(height: 20),
              const Text(
                'Experience OALP App', // Add your app name.
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Change the color of the indicator.
              )
            ],
          ),
        ),
      ),
    );
  }
}
