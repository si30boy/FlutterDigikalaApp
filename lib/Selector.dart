import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:google_fonts/google_fonts.dart';

class Selector extends StatefulWidget {
  const Selector({super.key});

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.2),
              Text(
                'خوش آمدید',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  fontFamily: 'iransans',
                ),
              ),

              SizedBox(height: screenHeight * 0.5),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  fixedSize: Size(screenWidth * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                child: Text(
                  'ورود',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    fontFamily: 'iransans',
                  ),
                ),
              ),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Signup()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  fixedSize: Size(screenWidth * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                child: Text(
                  'ثبت نام',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    fontFamily: 'iransans',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedButtonSelector extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String textInElevation;
  final VoidCallback onPressed;

  const ElevatedButtonSelector({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.textInElevation,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        fixedSize: Size(screenWidth * 0.8, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 8),
      ),
      child: Text(
        textInElevation,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          fontFamily: 'iransans',
        ),
      ),
    );
  }
}
