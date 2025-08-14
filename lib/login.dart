import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Selector.dart';
import 'package:flutter_application_1/adminhome.dart';
import 'package:flutter_application_1/admininsertitem.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _usernameOrEmailController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final supabase = Supabase.instance.client;
      String input = _usernameOrEmailController.text.trim();
      String email = input;

      // اگر ورودی ایمیل نبود، فرض بر username بودن است
      if (!input.contains('@')) {
        final sql = """
        SELECT email FROM users WHERE username = '${input}' LIMIT 1;
        """;

        final response = await supabase.rpc(
          'executesql',
          params: {'query': sql},
        );

        if (response == null || response.isEmpty) {
          throw Exception('نام کاربری وجود ندارد.');
        }

        email = response[0]['email'];
      }

      debugPrint('Trying login with: $email');

      final result = await supabase.auth.signInWithPassword(
        email: email,
        password: _passwordController.text.trim(),
      );

      if (result.user == null) {
        throw Exception('ورود ناموفق بود.');
      }

      debugPrint('Login successful: ${result.user!.email}');

      // رفتن به صفحه خانه
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } catch (e) {
      String errorMessage = 'خطا در ورود: ${e.toString()}';
      if (e is AuthException) {
        if (e.message.contains('invalid')) {
          errorMessage = 'ایمیل یا رمز عبور اشتباه است.';
        } else if (e.message.contains('not found')) {
          errorMessage = 'کاربری با این اطلاعات یافت نشد.';
        }
      }

      debugPrint(errorMessage);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _usernameOrEmailController.dispose();
    _passwordController.dispose();
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
          title: Text('ورود', style: TextStyle(fontFamily: 'iransans')),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: LoginUi(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          usernameOrEmailController: _usernameOrEmailController,
          passwordController: _passwordController,
          isLoading: _isLoading,
          formKey: _formKey,
          onLogin: _loginUser,
        ),
      ),
    );
  }
}

class LoginUi extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final TextEditingController usernameOrEmailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final VoidCallback onLogin;

  const LoginUi({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.usernameOrEmailController,
    required this.passwordController,
    required this.isLoading,
    required this.formKey,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'فروشگاه آنلاین من',
                style: TextStyle(
                  fontFamily: 'iransans',
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  letterSpacing: 0.5,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: screenHeight * 0.35,
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
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'نام کاربری یا ایمیل',
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
                        controller: usernameOrEmailController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'iransans',
                        ),
                        decoration: InputDecoration(
                          labelText: 'نام کاربری یا ایمیل',
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
                            CupertinoIcons.person,
                            color: Colors.black26,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفاً نام کاربری یا ایمیل وارد کنید';
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
                        controller: passwordController,
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
                            CupertinoIcons.lock,
                            color: Colors.black26,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفاً رمز عبور وارد کنید';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButtonSelector(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              textInElevation: 'ورود',
              onPressed: isLoading ? () {} : onLogin,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Signup()),
                );
              },
              child: const Text(
                'حساب کاربری ندارم',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blueAccent,
                  fontSize: 14,
                  fontFamily: 'iransans',
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              child: const Text(
                'حسابم',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blueAccent,
                  fontSize: 14,
                  fontFamily: 'iransans',
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminHome()),
                );
              },
              child: const Text(
                'حسابffffffم',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blueAccent,
                  fontSize: 14,
                  fontFamily: 'iransans',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}