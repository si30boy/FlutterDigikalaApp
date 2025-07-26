import 'package:flutter/material.dart';
import 'package:flutter_application_1/Selector.dart';
import 'package:flutter_application_1/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupPageState();
}

class _SignupPageState extends State<Signup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // ثبت‌نام کاربر با ایمیل در Supabase
      final response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.user == null) {
        throw Exception('ثبت‌نام ناموفق بود.');
      }

      // ذخیره اطلاعات اضافی در جدول users
      await Supabase.instance.client.from('users').insert({
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
      });

      _showSuccessDialog();
      _clearForm();
    } catch (e) {
      String errorMessage = 'خطای اتصال: $e';
      if (e is AuthException) {
        if (e.message.contains('already registered')) {
          errorMessage = 'این ایمیل قبلاً ثبت شده است.';
        } else if (e.message.contains('invalid')) {
          errorMessage = 'ایمیل یا رمز عبور نامعتبر است.';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'ثبت‌نام موفق',
          style: TextStyle(fontFamily: 'iransans'),
        ),
        content: const Text(
          'حساب شما با موفقیت ساخته شد.',
          style: TextStyle(fontFamily: 'iransans'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const login()),
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
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ثبت‌نام',
            style: TextStyle(fontFamily: 'iransans'),
          ),
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
                // const SizedBox(height: 20),
                // const Center(
                //   child: Text(
                //     'فروشگاه آنلاین من',
                //     style: TextStyle(
                //       fontFamily: 'iransans',
                //       fontWeight: FontWeight.w800,
                //       fontSize: 22,
                //       letterSpacing: 0.5,
                //       color: Colors.blueAccent,
                //     ),
                //   ),
                // ),
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
                              'نام کاربری',
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
                            controller: _usernameController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'iransans',
                            ),
                            decoration: InputDecoration(
                              labelText: 'نام کاربری',
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
                                Icons.person,
                                color: Colors.black26,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'لطفاً نام کاربری وارد کنید';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              'ایمیل',
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
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'iransans',
                            ),
                            decoration: InputDecoration(
                              labelText: 'ایمیل',
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
                                Icons.email,
                                color: Colors.black26,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'لطفاً ایمیل وارد کنید';
                              }
                              if (!value.contains('@') ||
                                  !value.contains('.')) {
                                return 'لطفاً ایمیل معتبر وارد کنید';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              'رمز عبور',
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
                            controller: _passwordController,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'iransans',
                            ),
                            decoration: InputDecoration(
                              labelText: 'رمز عبور',
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
                                Icons.lock,
                                color: Colors.black26,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'لطفاً رمز عبور وارد کنید';
                              }
                              if (value.length < 6) {
                                return 'رمز عبور باید حداقل 6 کاراکتر باشد';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              'تأیید رمز عبور',
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
                            controller: _confirmPasswordController,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'iransans',
                            ),
                            decoration: InputDecoration(
                              labelText: 'تأیید رمز عبور',
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
                                Icons.lock_outline,
                                color: Colors.black26,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'لطفاً رمز عبور را تأیید کنید';
                              }
                              if (value != _passwordController.text) {
                                return 'رمزهای عبور مطابقت ندارند';
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
                  textInElevation: 'ثبت‌نام',
                  onPressed: _isLoading ? () {} : _registerUser,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => login()),
                        );
                      },
                      child: const Text(
                        'ورود',
                        style: TextStyle(
                          fontFamily: 'iransans',
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    const Text(
                      'حساب کاربری دارم؟',
                      style: TextStyle(fontFamily: 'iransans'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
