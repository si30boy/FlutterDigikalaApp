import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('ورود', style: TextStyle(fontFamily: 'iransans')),
          centerTitle: true,
          leading: Icon(CupertinoIcons.back, color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}
