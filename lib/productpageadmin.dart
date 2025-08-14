import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Basketinfo.dart';
import 'package:flutter_application_1/Product.dart';
import 'package:flutter_application_1/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Productpageadmin extends StatelessWidget {
  final Product product; // محصولی که از صفحه اصلی دریافت می‌شود

  const Productpageadmin({Key? key, required this.product}) : super(key: key);

  // متد برای حذف محصول از دیتابیس
  Future<void> _deleteProduct(BuildContext context) async {
    try {
      final sql = """
      DELETE FROM products WHERE id = '${product.id}'
      RETURNING *;
      """;

      print('Executing SQL: $sql'); // دیباگ کوئری

      final response = await Supabase.instance.client.rpc(
        'executesql',
        params: {'query': sql},
      );

      print('Supabase response: $response'); // دیباگ پاسخ

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('محصول با موفقیت حذف شد')),
      );

      // بازگشت به صفحه قبلی (Home)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } catch (e) {
      if (!context.mounted) return;
      print('Error details: $e'); // دیباگ خطا
      String errorMessage = 'خطای حذف محصول: $e';
      if (e is PostgrestException) {
        if (e.message.contains('permission')) {
          errorMessage = 'عدم دسترسی به دیتابیس.';
        } else if (e.message.contains('not found')) {
          errorMessage = 'محصول یافت نشد.';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    }
  }

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
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteProduct(context),
              tooltip: 'حذف محصول',
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 10,
        ),
        body: _descriptionUi(context, product), // محصول به متد _descriptionUi ارسال می‌شود
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