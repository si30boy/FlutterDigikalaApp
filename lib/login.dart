import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Selector.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/signup.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('ورود', style: TextStyle(fontFamily: 'iransans')),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: LoginUi(screenHeight: screenHeight, screenWidth: screenWidth),
      ),
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
        SizedBox(height: 30),
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
        SizedBox(height: 30),
        Container(
          height: screenHeight * 0.35,
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
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 48),

        ElevatedButtonSelector(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          textInElevation: 'ورود',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),

        SizedBox(height: 16),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Signup()),
            );
          },
          child: Text(
            'حساب کاربری ندارم',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.blueAccent,
              fontSize: 14,
              fontFamily: 'iransans',
            ),
          ),
        ),
      ],
    );
  }
}
