import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/home.dart';

class AdminUpdateItem extends StatefulWidget {
  final int productId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const AdminUpdateItem({
    Key? key,
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

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
    _nameController = TextEditingController(text: widget.name);
    _descriptionController = TextEditingController(text: widget.description);
    _priceController = TextEditingController(text: widget.price.toString());
    _imageUrlController = TextEditingController(text: widget.imageUrl);
  }

  Future<void> _updateProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Supabase.instance.client
          .from('products')
          .update({
            'name': _nameController.text.trim(),
            'description': _descriptionController.text.trim(),
            'price': double.tryParse(_priceController.text.trim()) ?? 0,
            'image_url': _imageUrlController.text.trim(),
          })
          .eq('id', widget.productId);

      _showSuccessDialog();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا در به‌روزرسانی: $e'),
          backgroundColor: Colors.red,
        ),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('به‌روزرسانی موفق'),
        content: const Text('محصول با موفقیت ویرایش شد.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            child: const Text('تأیید'),
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
    return Scaffold(
      appBar: AppBar(title: const Text('ویرایش محصول'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'نام محصول'),
                validator: (value) =>
                    value!.isEmpty ? 'نام را وارد کنید' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'توضیحات محصول'),
                validator: (value) =>
                    value!.isEmpty ? 'توضیحات را وارد کنید' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'قیمت محصول'),
                validator: (value) => double.tryParse(value!) == null
                    ? 'قیمت معتبر وارد کنید'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'آدرس عکس'),
                validator: (value) =>
                    value!.isEmpty ? 'آدرس عکس را وارد کنید' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _updateProduct,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('ذخیره تغییرات'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
