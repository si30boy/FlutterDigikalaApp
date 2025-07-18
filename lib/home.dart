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
              color: Colors.black45,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 20,

          selectedFontSize: 14,
          selectedIconTheme: IconThemeData(color: Colors.teal, size: 30),
          selectedItemColor: Colors.teal,
          selectedLabelStyle: TextStyle(
            color: Colors.blue,
            fontFamily: 'iransans',
            fontWeight: FontWeight.w600,
          ),

          unselectedIconTheme: IconThemeData(size: 30),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'iransans',
            fontWeight: FontWeight.w200,
          ),

          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: 'تنظیمات',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'صفحه اصلی',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart),
              label: 'سبد خرید',
            ),
          ],
        ),
      ),
    );
  }
}
