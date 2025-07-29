import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Product.dart';
import 'package:flutter_application_1/productpage.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Product> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    // این فراخوانی محصولات از دیتابیس در اینجا صحیح است.
    _fetchProductsFromSupabase();
  }

  Future<void> _fetchProductsFromSupabase() async {
    try {
      final response = await Supabase.instance.client.from('products').select();
      // Supabase client returns a List<Map<String, dynamic>>
      final data = response as List;
      setState(() {
        _items = data.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
        _loading = false;
      });
    } catch (e) {
      // خطاها رو اینجا هندل کنید، مثلاً با نمایش یک Snackbar
      print('Error fetching products: $e');
      setState(() {
        _loading = false;
      });
      // می‌تونید اینجا یک پیام خطا به کاربر نشون بدید
      if (mounted) { // بررسی کنید که ویجت هنوز در درخت هست یا نه
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطا در دریافت محصولات: $e')),
        );
      }
    }
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // **مهم**: MaterialApp از اینجا حذف شده و باید در main.dart قرار داشته باشه.
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
            onPressed: () {
              // TODO: Implement cart functionality
            },
            icon: const Icon(CupertinoIcons.shopping_cart),
            color: Colors.black45,
          ),
        ],
      ),
      body: _loading ? const Center(child: CircularProgressIndicator()) : _mainUi(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 20,
        selectedFontSize: 15,
        selectedIconTheme: const IconThemeData(color: Colors.teal, size: 30),
        selectedItemColor: Colors.teal,
        selectedLabelStyle: const TextStyle(
          color: Colors.blue,
          fontFamily: 'iransans',
          fontWeight: FontWeight.w600,
        ),
        unselectedIconTheme: const IconThemeData(size: 30),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'iransans',
          fontWeight: FontWeight.w200,
        ),
        items: const [
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
    );
  }

  Widget _mainUi() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              // TODO: Navigate to "Most Popular Products" page
            },
            child: Container(
              height: 60,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Row(
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
          SizedBox(
            height: 310,
           // margin: const EdgeInsets.only(bottom: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: List.generate(_items.length, (index) {
                  return Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: _generateItems(_items[index], context),
                  );
                }),
              ),
            ),
          ),
          Container(
            height: 120,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              elevation: 8,
              child: Image.network(
                'https://s6.uupload.ir/files/ban_4_jxpg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 120,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    elevation: 8,
                    child: Image.network(
                      'https://s6.uupload.ir/files/ban_5_s0pa.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 120,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    elevation: 8,
                    child: Image.network(
                      'https://s6.uupload.ir/files/ban_6_9iey.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 120,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Card(
              shape: const RoundedRectangleBorder(
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

  Widget _generateItems(Product product, BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      elevation: 10,
      child: InkWell(
        onTap: () {
          // Navigator اینجا به درستی کار می‌کند چون MyApp در main.dart شامل MaterialApp هست.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Productpage(product: product)),
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
              const SizedBox(height: 4),
              SizedBox(
                width: 220,
                height: 50,
                child: Text(
                  product.name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'iransans',
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1.4,
                endIndent: 15,
                indent: 15,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(
                        fontFamily: 'iransans',
                        fontSize: 16,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.price,
                      style: const TextStyle(
                        fontFamily: 'iransans',
                        fontSize: 16,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
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
}