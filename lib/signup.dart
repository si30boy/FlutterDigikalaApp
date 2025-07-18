import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Selector.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // ✅ فقط از Scaffold استفاده کن
      appBar: AppBar(
        title: Text('ثبت نام', style: TextStyle(fontFamily: 'iransans')),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: LoginUi(screenHeight: screenHeight, screenWidth: screenWidth),
    );
  }
}

class LoginUi extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  const LoginUi({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 28),
        Center(
          child: Text(
            'فروشگاه آنلاین من',
            style: TextStyle(
              fontFamily: 'iransans',
              fontWeight: FontWeight.w800,
              fontSize: 22,
              letterSpacing: 0.5,
              color: Colors.blueAccent,
            ),
          ),
        ),
        SizedBox(height: 28),
        Container(
          height: screenHeight * 0.45,
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
            elevation: 4,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(0, 0, 30, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'نام کاربری',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'iransans',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(40, 0, 40, 0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'iransans',
                      ),
                      decoration: InputDecoration(
                        hintText: 'شماره تماس',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: 'iransans',
                        ),
                        suffixIcon: Icon(
                          CupertinoIcons.phone,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(0, 0, 30, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'رمز عبور',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'iransans',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(40, 0, 40, 0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'iransans',
                      ),
                      decoration: InputDecoration(
                        hintText: 'کلمه عبور',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: 'iransans',
                        ),
                        suffixIcon: Icon(
                          CupertinoIcons.lock,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(0, 0, 30, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ' تکرار رمز عبور',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'iransans',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(40, 0, 40, 0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'iransans',
                      ),
                      decoration: InputDecoration(
                        hintText: 'تکرار کلمه عبور',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: 'iransans',
                        ),
                        suffixIcon: Icon(
                          CupertinoIcons.lock,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 36),

        ElevatedButtonSelector(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          textInElevation: 'ثبت نام',
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('ثبت‌نام انجام شد ✅')));
          },
        ),
      ],
    );
  }
}
