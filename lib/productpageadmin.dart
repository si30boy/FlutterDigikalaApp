import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Basketinfo.dart';
import 'package:flutter_application_1/Product.dart';
import 'package:flutter_application_1/adminhome.dart';
import 'package:flutter_application_1/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Productpageadmin extends StatefulWidget {
  final Product product; // محصولی که از صفحه اصلی دریافت می‌شود

  const Productpageadmin({Key? key, required this.product}) : super(key: key);

  @override
  State<Productpageadmin> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpageadmin> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController = TextEditingController(
      text: widget.product.description,
    );
    _priceController = TextEditingController(text: widget.product.price);
    _imageUrlController = TextEditingController(text: widget.product.image);
  }

  // متد برای حذف محصول از دیتابیس
  Future<void> _deleteProduct(BuildContext context) async {
    try {
      final sql =
          """
      DELETE FROM products WHERE id = '${widget.product.id}'
      RETURNING *;
      """;

      print('Executing SQL: $sql'); // دیباگ کوئری

      final response = await Supabase.instance.client.rpc(
        'executesql',
        params: {'query': sql},
      );

      print('Supabase response: $response'); // دیباگ پاسخ

      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('محصول با موفقیت حذف شد')));

      // بازگشت به صفحه قبلی (Home)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminHome()),
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

  // متد برای آپدیت محصول در دیتابیس
  Future<void> _updateProduct(BuildContext context) async {
    try {
      final newName = _nameController.text.trim().replaceAll("'", "''");
      final newDescription = _descriptionController.text.trim().replaceAll(
        "'",
        "''",
      );
      final newPrice = double.tryParse(_priceController.text.trim()) ?? 0;
      final newImageUrl = _imageUrlController.text.trim().replaceAll("'", "''");

      final sql =
          """
      UPDATE products SET name = '$newName', description = '$newDescription', price = $newPrice, image_url = '$newImageUrl' WHERE id = '${widget.product.id}'
      RETURNING *;
      """;

      print('Executing SQL: $sql'); // دیباگ کوئری

      final response = await Supabase.instance.client.rpc(
        'executesql',
        params: {'query': sql},
      );

      print('Supabase response: $response'); // دیباگ پاسخ

      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تغییرات با موفقیت ثبت شد')));

      // بازگشت به صفحه قبلی (Home)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminHome()),
      );
    } catch (e) {
      if (!context.mounted) return;
      print('Error details: $e'); // دیباگ خطا
      String errorMessage = 'خطای ثبت تغییرات: $e';
      if (e is PostgrestException) {
        if (e.message.contains('permission')) {
          errorMessage = 'عدم دسترسی به دیتابیس.';
        } else if (e.message.contains('syntax')) {
          errorMessage = 'خطای سینتکس در کوئری SQL.';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ویرایش محصول',
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
              MaterialPageRoute(builder: (context) => AdminHome()),
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
        body: _descriptionUi(
          context,
          widget.product,
        ), // محصول به متد _descriptionUi ارسال می‌شود
      ),
    );
  }

  // متد خصوصی برای نمایش جزئیات محصول با فیلدهای ویرایشی
  Widget _descriptionUi(BuildContext context, Product product) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 16),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.6,
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _imageUrlController,
              builder: (context, value, child) {
                return Image.network(
                  value.text,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.grey,
                  ),
                );
              },
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
                child: TextFormField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'نام محصول',
                    hintStyle: const TextStyle(
                      fontFamily: 'iransans',
                      fontSize: 20,
                      color: Colors.grey,
                    ),
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
                child: TextFormField(
                  controller: _descriptionController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'توضیحات محصول',
                    hintStyle: const TextStyle(
                      fontFamily: 'iransans',
                      fontSize: 18,
                      color: Colors.grey,
                    ),
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
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontFamily: 'iransans',
                          fontSize: 18,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'قیمت',
                          hintStyle: const TextStyle(
                            fontFamily: 'iransans',
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                child: TextFormField(
                  controller: _imageUrlController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'آدرس عکس',
                    hintStyle: const TextStyle(
                      fontFamily: 'iransans',
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {}); // برای به‌روزرسانی تصویر
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: InkWell(
              onTap: () {
                _updateProduct(context);
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
                    'ثبت تغییرات',
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
