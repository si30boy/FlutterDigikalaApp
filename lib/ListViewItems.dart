import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Product.dart';

typedef RemoveItem(int index);

class ListViewItems extends StatefulWidget {
  Product _product;
  int _count = 0;
  RemoveItem _RemoveItem;
  int _index;

  ListViewItems(this._product, this._RemoveItem, this._index);

  @override
  State<ListViewItems> createState() => _ListViewItemsState();
}

class _ListViewItemsState extends State<ListViewItems> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      elevation: 8,

      child: Container(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            //product image
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 130,
                width: 130,
                child: Image.network(
                  widget._product.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //product title & price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                  child: Container(
                    height: 60,
                    width: 180,
                    child: Text(
                      widget._product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'iransans',
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 2, // فقط ۲ خط نمایش بده
                      overflow: TextOverflow.clip, // اگر بیشتر بود با ... نشون
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 28, 0, 0),
                  child: Container(
                    height: 20,
                    width: 180,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 2),
                        InkWell(
                          onTap: () => widget._RemoveItem(widget._index),

                          child: Icon(CupertinoIcons.delete, color: Colors.red),
                        ),
                        Row(
                          children: [
                            Text(
                              'تومان',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'iransans',
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 2),
                            Text(
                              widget._product.price,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'iransans',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
