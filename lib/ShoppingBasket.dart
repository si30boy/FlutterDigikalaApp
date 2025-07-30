import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';

class Shoppingbasket extends StatefulWidget {
  const Shoppingbasket({super.key});

  @override
  State<Shoppingbasket> createState() => _ShoppingbasketState();
}

class _ShoppingbasketState extends State<Shoppingbasket> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'سبد خرید شما ',
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
            shoppingBasketUi(context), // محصول به متد _descriptionUi ارسال می‌شود
      ),
    );;
  }
  Widget shoppingBasketUi(context){
    return Stack(

      children: [

      ],

    );
  }


}