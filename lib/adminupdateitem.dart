import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/Product.dart';
import 'package:flutter_application_1/Selector.dart';

class AdminUpdateItem extends StatefulWidget {
  final Product product;

  const AdminUpdateItem({Key? key, required this.product}) : super(key: key);

  @override
  State<AdminUpdateItem> createState() => _AdminUpdateItemState();
}

class _AdminUpdateItemState extends State<AdminUpdateItem> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController = TextEditingController(text: widget.product.description);
    _priceController = TextEditingController(text: widget.product.price);
    _imageUrlController = TextEditingController(text: widget.product.image);
  }

  Future<void> _updateProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final name = _nameController.text.trim();
      final description = _descriptionController.text.trim();
      final price = double.tryParse(_priceController.text.trim()) ?? 0;
      final imageUrl = _imageUrlController.text.trim();

      await Supabase.instance.client.from('products').update({
        'name': name,
        'description': description,
        'price': price,
        'image_url': imageUrl,
      }).eq('id', widget.product.id);

      if (!mounted) return;
      _showSuccessDialog();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطای اتصال: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('بروزرسانی موفق', style: TextStyle(fontFamily: 'iransans')),
        content: const Text('محصول با موفقیت ویرایش شد.', style: TextStyle(fontFamily: 'iransans')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            child: const Text('تأیید', style: TextStyle(fontFamily: 'iransans')),
          ),
        ],
      ),
    );
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
              title: const Text('ویرایش محصول', style: TextStyle(fontFamily: 'iransans')),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              buildLabel('نام محصول'),
                              buildTextField(_nameController, 'نام محصول', 'مثلاً: گوشی موبایل', Icons.inventory),
                              buildLabel('توضیحات محصول'),
                              buildTextField(_descriptionController, 'توضیحات محصول', 'مثلاً: توضیحات کوتاه', Icons.description),
                              buildLabel('قیمت محصول'),
                              buildTextField(_priceController, 'قیمت محصول', 'مثلاً: 5000000', Icons.attach_money, isNumber: true),
                              buildLabel('آدرس عکس محصول'),
                              buildTextField(_imageUrlController, 'آدرس عکس', 'https://example.com/img.jpg', Icons.image),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButtonSelector(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      textInElevation: 'ذخیره تغییرات',
                      onPressed: _isLoading ? () {} : _updateProduct,
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

  Widget buildLabel(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'iransans',
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, String hint, IconData icon, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'iransans',
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: 'iransans', color: Colors.grey),
        labelStyle: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black54, fontSize: 16, fontFamily: 'iransans'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: Icon(icon, color: Colors.black26),
      ),
      textDirection: TextDirection.ltr,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'لطفاً $label را وارد کنید';
        }
        if (isNumber && double.tryParse(value) == null) {
          return 'لطفاً عدد معتبر وارد کنید';
        }
        return null;
      },
    );
  }
}
