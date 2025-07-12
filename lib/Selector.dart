import 'package:flutter/material.dart';
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
              Text('خوشas آمدید'),

              SizedBox(height: screenHeight * 0.5),
              ElevatedButtonSelector(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                textInElevation: 'ورود',
              ),
              SizedBox(height: 16),
              ElevatedButtonSelector(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                textInElevation: 'ثبت نام',
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

  const ElevatedButtonSelector({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.textInElevation,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        fixedSize: Size(screenWidth * 0.8, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        textInElevation,
        style: GoogleFonts.exo2(fontWeight: FontWeight.w600, fontSize: 22),
      ),
    );
  }
}
