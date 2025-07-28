import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Product.dart';
import 'package:flutter_application_1/productpage.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;
  List<Product> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchProductsFromSupabase();
  }

  Future<void> fetchProductsFromSupabase() async {
    try {
      final response = await Supabase.instance.client.from('products').select();
      final data = response as List;
      setState(() {
        _items = data.map((item) => Product.fromJson(item)).toList();
        _loading = false;
      });
    } catch (error) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطا در دریافت محصولات: $error')),
      );
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await Supabase.instance.client.from('products').delete().eq('id', id);
      await fetchProductsFromSupabase(); // Refresh the list after deletion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('محصول با موفقیت حذف شد')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطا در حذف محصول: $error')),
      );
    }
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'پنل مدیریت',
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
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : MainUi(),
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
              label: 'خانه',
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
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
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
                    'محصولات ثبت شده',
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
            margin: EdgeInsets.only(bottom: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: List.generate(_items.length, (index) {
                  return Container(
                    width: 260,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: generateItems(
                      _items[index],
                      context,
                      () => deleteProduct(_items[index].id as int),
                    ),
                  );
                }),
              ),
            ),
          ),
          Container(
            height: 120,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              elevation: 8,
              child: Image.network(
                'https://s6.uupload.ir/files/ban_4_jxpg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 120,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    elevation: 8,
                    child: Image.network(
                      'https://s6.uupload.ir/files/ban_5_s0pa.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    elevation: 8,
                    child: Image.network(
                      'https://s6.uupload.ir/files/ban_6_9iey.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 120,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              elevation: 8,
              child: Image.network(
                'https://s6.uupload.ir/files/ban_7_b9gw.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget generateItems(Product product, BuildContext context, VoidCallback onDelete) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    elevation: 10,
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Productpage(product)),
        );
      },
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
              width: 222,
              height: 50,
              child: Text(
                product.name,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'iransans',
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 4),
            Divider(
              height: 1,
              color: Colors.grey,
              thickness: 1.4,
              endIndent: 15,
              indent: 15,
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'تومان',
                        style: TextStyle(
                          fontFamily: 'iransans',
                          fontSize: 16,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        product.price,
                        style: TextStyle(
                          fontFamily: 'iransans',
                          fontSize: 16,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}