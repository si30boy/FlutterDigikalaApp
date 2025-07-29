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
              title: Text(
                'جزییات محصول',
                style: TextStyle(fontFamily: 'iransans'),
              ),
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
        },
      ),
    );

    ;
  }

  Widget DescriptionUi(context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 8),
          Container(
            height: 170,
            width: MediaQuery.of(context).size.width / 2,
            child: Image.network(_product.image, fit: BoxFit.fill),
          ),
          SizedBox(height: 8),
          Container(
            height: 80,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              elevation: 8,
              child: Center(
                child: Text(
                  _product.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'iransans',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              elevation: 8,
              child: Center(
                child: Text(
                  _product.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'iransans',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 18),
                child: InkWell(
                  onTap: () {},

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'افزودن به سبد خرید',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'iransans',
                          fontSize: 18,
                        ),
                      ),
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
