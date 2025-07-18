import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Product.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // ✅ اینجا تعریفش کن
  final List<Product> _items = [
    Product(
      '1',
      'کنسول بازی ',
      '130001234',
      'https://s6.uupload.ir/files/consoleimage_irmt.jpg',
      'قیمت عای و مناسب',
    ),
    Product(
      '2',
      'کنسول بازی ',
      '130342324',
      'https://s6.uupload.ir/files/consoleimage_irmt.jpg',
      'قیمت عای و مناسب',
    ),
    Product(
      '3',
      'کنسول بازی ',
      '135252555',
      'https://s6.uupload.ir/files/consoleimage_irmt.jpg',
      'قیمت عای و مناسب',
    ),
  ];

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
              color: Colors.teal,
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
              SizedBox(height: 12),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.back),
                      Text(
                        'پر فروشترین محصولات',
                        style: TextStyle(
                          fontFamily: 'iransans',
                          fontWeight: FontWeight.w800,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 310,
                color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 15,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(_items.length, (int position) {
                      return generateItems(_items[position], (context));
                    }),
                  ),
                ),
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

Widget generateItems(Product product, BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    elevation: 10,
    child: InkWell(
      onTap: () {},
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 190,
              height: 170,
              child: Image.network(product.image, fit: BoxFit.contain),
            ),
            SizedBox(height: 4),
            Container(
              width: 220,
              height: 50,
              child: Text(
                product.name,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black, fontFamily: 'iransans'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
