import 'package:flutter/material.dart';
import 'package:flutter_application_1/Selector.dart';
import 'package:flutter_application_1/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Admininsertitem extends StatefulWidget {
  const Admininsertitem({Key? key}) : super(key: key);

  @override
  State<Admininsertitem> createState() => _AdmininsertitemState();
}

class _AdmininsertitemState extends State<Admininsertitem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _submitProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final name = _nameController.text.trim().replaceAll("'", "''"); // فرار کردن تک‌کوتیشن
      final description = _descriptionController.text.trim().replaceAll("'", "''");
      final price = double.tryParse(_priceController.text.trim()) ?? 0;
      final imageUrl = _imageUrlController.text.trim().replaceAll("'", "''");

      final sql = """
      INSERT INTO products (name, description, price, image_url)
      VALUES ('$name', '$description', $price, '$imageUrl')
      RETURNING *;
      """;

      print('Executing SQL: $sql'); // دیباگ کوئری

      final response = await Supabase.instance.client.rpc(
        'executesql',
        params: {'query': sql},
      );

      print('Supabase response: $response'); // دیباگ پاسخ

      if (!mounted) return;

      _showSuccessDialog();
      _clearForm();
    } catch (e) {
      if (!mounted) return;
      print('Error details: $e'); // دیباگ خطا
      String errorMessage = 'خطای اتصال: $e';
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
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ثبت موفق', style: TextStyle(fontFamily: 'iransans')),
        content: const Text(
          'محصول با موفقیت ثبت شد.',
          style: TextStyle(fontFamily: 'iransans'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            child: const Text(
              'تأیید',
              style: TextStyle(fontFamily: 'iransans'),
            ),
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _imageUrlController.clear();
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'ثبت محصول',
                style: TextStyle(fontFamily: 'iransans'),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Selector(),)),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 28),
                    Container(
                      height: screenHeight * 0.64,
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  'نام محصول',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'iransans',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _nameController,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'iransans',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'نام محصول',
                                  hintText: 'مثلاً: گوشی موبایل',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'iransans',
                                    color: Colors.grey,
                                  ),
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontFamily: 'iransans',
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.inventory,
                                    color: Colors.black26,
                                  ),
                                ),
                                textDirection:
                                    TextDirection.ltr, // Hint به سمت چپ
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'لطفاً نام محصول را وارد کنید';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  'توضیحات محصول',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'iransans',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _descriptionController,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'iransans',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'توضیحات محصول',
                                  hintText: 'مثلاً: توضیحات کوتاه درباره محصول',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'iransans',
                                    color: Colors.grey,
                                  ),
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontFamily: 'iransans',
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.description,
                                    color: Colors.black26,
                                  ),
                                ),
                                textDirection:
                                    TextDirection.ltr, // Hint به سمت چپ
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'لطفاً توضیحات محصول را وارد کنید';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  'قیمت محصول',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'iransans',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'iransans',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'قیمت محصول',
                                  hintText: 'مثلاً: 5000000',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'iransans',
                                    color: Colors.grey,
                                  ),
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontFamily: 'iransans',
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.attach_money,
                                    color: Colors.black26,
                                  ),
                                ),
                                textDirection:
                                    TextDirection.ltr, // Hint به سمت چپ
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'لطفاً قیمت را وارد کنید';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'لطفاً قیمت معتبر وارد کنید';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  'آدرس عکس محصول',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'iransans',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _imageUrlController,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'iransans',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'آدرس عکس محصول',
                                  hintText:
                                      'مثلاً: https://example.com/image.jpg',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'iransans',
                                    color: Colors.grey,
                                  ),
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontFamily: 'iransans',
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.image,
                                    color: Colors.black26,
                                  ),
                                ),
                                textDirection:
                                    TextDirection.ltr, // Hint به سمت چپ
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'لطفاً آدرس عکس را وارد کنید';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButtonSelector(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      textInElevation: 'ثبت محصول',
                      onPressed: _isLoading ? () {} : _submitProduct,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}