
import 'package:flutter_application_1/Product.dart';

class BasketInfo {


  static BasketInfo _template = BasketInfo();
  List<Product> _basketItems = [];

  BasketInfo(){

    _basketItems = <Product>[];

  }

  List<Product> get basketItems => _basketItems;

  static BasketInfo getTemplate(){

    if(_template == null){

      _template = BasketInfo();
    }

    return _template;

  }

  set basketItems(List<Product> value){
    _basketItems  =value;
  }
}