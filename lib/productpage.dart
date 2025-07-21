import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Product.dart';

class Productpage extends StatelessWidget {
  

  Product _product;
  Productpage(this._product);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('جزییات محصول', style: TextStyle(fontFamily: 'iransans')),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(CupertinoIcons.back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: DescriptionUi(context),
          );
        }
      ),
    );
  
  ;
  }

  Widget DescriptionUi(context){
    return Container(
      color: Colors.red,


    );
  }


}
