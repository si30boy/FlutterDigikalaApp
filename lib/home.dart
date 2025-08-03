import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:flutter_application_1/Product.dart';
import 'package:flutter_application_1/ShoppingBasket.dart';
import 'package:flutter_application_1/productpage.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PersistentTabController _controller;
  List<Product> _items = [];
  bool _loading = true;
  bool _hideNavBar = false;
  final ScrollController _homeScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 1);
    _fetchProductsFromSupabase();
  }

  Future<void> _fetchProductsFromSupabase() async {
    try {
      final response = await Supabase.instance.client.from('products').select();
      final data = response as List;
      setState(() {
        _items = data
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList();
        _loading = false;
      });
    } catch (e) {
      debugPrint('Error fetching products: $e');
      setState(() {
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطا در دریافت محصولات: $e')));
      }
    }
  }

  List<Widget> _buildScreens() => [
    // تنظیمات
    Scaffold(
      appBar: AppBar(
        title: const Text(
          'تنظیمات',
          style: TextStyle(
            fontFamily: 'iransans',
            fontWeight: FontWeight.w800,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: const Center(
        child: Text('صفحه‌ی تنظیمات', style: TextStyle(fontSize: 16)),
      ),
    ),
    // صفحه‌ی اصلی
    Scaffold(
      backgroundColor: Colors.grey.shade50,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Shoppingbasket()),
              );
            },
            icon: const Icon(CupertinoIcons.shopping_cart),
            color: Colors.black45,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _mainUi(),
    ),
    // سبد خرید
    Scaffold(
      appBar: AppBar(
        title: const Text(
          'سبد خرید',
          style: TextStyle(
            fontFamily: 'iransans',
            fontWeight: FontWeight.w800,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: const Center(
        child: Text('سبد خرید شما خالی است', style: TextStyle(fontSize: 16)),
      ),
    ),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.settings),
      title: "تنظیمات",
      activeColorPrimary: Colors.teal.shade700,
      activeColorSecondary: Colors.white,
      inactiveColorPrimary: Colors.grey.shade600,
      textStyle: const TextStyle(
        fontFamily: 'iransans',
        fontWeight: FontWeight.w600,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: "خانه",
      activeColorPrimary: Colors.teal,
      activeColorSecondary: Colors.white,
      inactiveColorPrimary: Colors.grey.shade600,
      textStyle: const TextStyle(
        fontFamily: 'iransans',
        fontWeight: FontWeight.w600,
      ),
      scrollController: _homeScrollController,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.shopping_cart),
      title: "سبد خرید",
      activeColorPrimary: Colors.deepOrangeAccent,
      activeColorSecondary: Colors.white,
      inactiveColorPrimary: Colors.grey.shade600,
      textStyle: const TextStyle(
        fontFamily: 'iransans',
        fontWeight: FontWeight.w600,
      ),
    ),
  ];

  Widget _mainUi() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      controller: _homeScrollController,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Productpage(product: product),
            ),
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

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: Colors.grey.shade50,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: false,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      navBarStyle: NavBarStyle.style10,
      navBarHeight: kBottomNavigationBarHeight + 8,
      padding: const EdgeInsets.only(top: 6),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(16),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, -3),
            blurRadius: 12,
          ),
        ],
      ),
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeOutQuint,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 280),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
        onNavBarHideAnimation: OnHideAnimationSettings(
          duration: Duration(milliseconds: 180),
          curve: Curves.easeInOut,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: const Icon(Icons.add, size: 28, color: Colors.white),
        onPressed: () {
          // اکشن دکمه شناور
        },
      ),
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      isVisible: !_hideNavBar,
      selectedTabScreenContext: (ctx) {
        // اگر لازم بود از این کانتکست استفاده کنی
      },
    );
  }
}
