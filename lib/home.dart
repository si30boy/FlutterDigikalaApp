import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // ✅ اینجا تعریفش کن

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'فروشگاه من',
            style: TextStyle(
              fontFamily: 'iransans',
              fontWeight: FontWeight.w800,
              color: Colors.blue,
            ),
          ),
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
        body: MainUi(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 20,
          selectedFontSize: 15,
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
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ),
      ),
    );
  }

  Widget MainUi() {
    return Builder(
      builder: (context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ImageSlideshow(
                width: double.infinity,
                height: 160,
                initialPage: 0,
                indicatorColor: Colors.white,
                indicatorBackgroundColor: Colors.grey,
                autoPlayInterval: 6000,
                isLoop: true,
                children: [
                  Image.asset('assets/images/slider2.jpg', fit: BoxFit.fill),
                  Image.asset('assets/images/slider4.jpg', fit: BoxFit.fill),
                  Image.asset('assets/images/slider5.jpg', fit: BoxFit.fill),
                  Image.asset('assets/images/slider6.jpg', fit: BoxFit.fill),
                  Image.asset('assets/images/slider7.jpg', fit: BoxFit.fill),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
