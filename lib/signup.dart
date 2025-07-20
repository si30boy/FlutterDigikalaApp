import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController =
      TextEditingController();

  bool isLoading = false;

  void register() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final passwordRepeat = passwordRepeatController.text.trim();

    if (username.isEmpty || password.isEmpty || passwordRepeat.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('لطفا همه فیلدها را پر کنید')));
      return;
    }

    if (password != passwordRepeat) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('رمز عبور و تکرار آن مطابقت ندارند')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var url = Uri.parse(
        'http://192.168.1.10:8000/register/',
      ); // آدرس سرور خودت

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': username, // اگر ایمیل داری جایگزین کن
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('ثبت‌نام با موفقیت انجام شد!')));
        // اینجا میتونی صفحه بعدی رو باز کنی یا فرم رو پاک کنی
      } else {
        var data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا: ${data['detail'] ?? 'مشکل در ثبت نام'}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطا در اتصال به سرور')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('ثبت نام', style: TextStyle(fontFamily: 'iransans')),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 28),
            Center(
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
            SizedBox(height: 28),
            Container(
              height: screenHeight * 0.55,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      // نام کاربری
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'نام کاربری',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'iransans',
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: usernameController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'iransans',
                        ),
                        decoration: InputDecoration(
                          hintText: 'شماره تماس یا ایمیل',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontSize: 16,
                            fontFamily: 'iransans',
                          ),
                          suffixIcon: Icon(
                            CupertinoIcons.person,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // رمز عبور
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'رمز عبور',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'iransans',
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'iransans',
                        ),
                        decoration: InputDecoration(
                          hintText: 'کلمه عبور',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontSize: 16,
                            fontFamily: 'iransans',
                          ),
                          suffixIcon: Icon(
                            CupertinoIcons.lock,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // تکرار رمز عبور
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'تکرار رمز عبور',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'iransans',
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: passwordRepeatController,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'iransans',
                        ),
                        decoration: InputDecoration(
                          hintText: 'تکرار کلمه عبور',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontSize: 16,
                            fontFamily: 'iransans',
                          ),
                          suffixIcon: Icon(
                            CupertinoIcons.lock,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: register,
                              child: Text(
                                'ثبت نام',
                                style: TextStyle(fontFamily: 'iransans'),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
