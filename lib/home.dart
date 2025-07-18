import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('فروشگاه من'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 10,

          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.shopping_cart),
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
