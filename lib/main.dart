import 'package:flutter/material.dart';
import 'package:flutter_application_1/admininsertitem.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_application_1/Selector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sehsmxihuuproztzqojm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlaHNteGlodXVwcm96dHpxb2ptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM0NTY2MjcsImV4cCI6MjA2OTAzMjYyN30.4M6jo33ilgtn4kyr-oYEsxhoZfU9mpgfjsv8zbgz5eE',
  );

  runApp(Admininsertitem());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashWithLottie(),
    );
  }
}

class SplashWithLottie extends StatefulWidget {
  const SplashWithLottie({super.key});

  @override
  State<SplashWithLottie> createState() => _SplashWithLottieState();
}

class _SplashWithLottieState extends State<SplashWithLottie> {
  @override
  void initState() {
    super.initState();

    // بعد از ۳ ثانیه رفتن به صفحه بعد
    Future.delayed(Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Selector()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/animationintro.json',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    'به فروشگاه خوش آمدید',
                    speed: Duration(milliseconds: 140),
                    textStyle: TextStyle(
                      fontFamily: 'iransans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
