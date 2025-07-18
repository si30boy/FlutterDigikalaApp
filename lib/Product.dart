class Product {
  String _id;
  String _name;
  String _price;
  String _image;
  String _description;

  Product(this._id, this._name, this._price, this._image, this._description);

  String get id => _id;
  String get name => _name;
  String get price => _price;
  String get image => _image;
  String get description => _description;

  set id(String value) {
    id = value;
  }

  set name(String value) {
    name = value;
  }

  set price(String value) {
    price = value;
  }

  set image(String value) {
    image = value;
  }

  set description(String value) {
    description = value;
  }
}
