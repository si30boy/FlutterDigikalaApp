import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Basketinfo.dart';
import 'package:flutter_application_1/Product.dart';
import 'package:flutter_application_1/home.dart'; // مطمئن شوید که Product را ایمپورت کرده‌اید

class Productpage extends StatelessWidget {
  final Product product; // محصولی که از صفحه اصلی دریافت می‌شود

  const Productpage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'جزییات محصول',
            style: TextStyle(
              fontFamily: 'iransans',
              fontWeight: FontWeight.w600,
              color: Colors.teal,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: Colors.black),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),)),
          ),
          backgroundColor: Colors.white,
          elevation: 10,
        ),
        body:
            _descriptionUi(context, product), // محصول به متد _descriptionUi ارسال می‌شود
      ),
    );
  }

  // متد خصوصی برای نمایش جزئیات محصول
  Widget _descriptionUi(BuildContext context, Product product) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 16),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.network(
              product.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 100, color: Colors.grey),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(
                        fontFamily: 'iransans',
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product.price,
                      style: const TextStyle(
                        fontFamily: 'iransans',
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: InkWell(
              onTap: () {



                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('محصول به سبد خرید اضافه شد')),
                );


                print('size before click ' + BasketInfo.getTemplate().basketItems.length.toString());


                
                BasketInfo.getTemplate().basketItems.add(product);
                
                print('size after click ' + BasketInfo.getTemplate().basketItems.length.toString());

               
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 60,
                width: double.infinity,
                child: const Center(
                  child: Text(
                    'افزودن به سبد خرید',
                    style: TextStyle(
                      fontFamily: 'iransans',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}