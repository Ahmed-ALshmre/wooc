class Product {
  int id;
  String name;
  String description;
  int rating_count;
  String shortDescription;
  String sku;
  String price;
  String salePrice;
  String regularPrice;
  List<Images> images;
  List<Categories> categories;
  String stockStatus;

  Product(
      this.id,
      this.rating_count,
      this.stockStatus,
      this.name,
      this.description,
      this.shortDescription,
      this.sku,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.images,
      this.categories);

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating_count = json['rating_count'];
    name = json['name'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    stockStatus = json['stock_Status'];
    if (json['categories'] != null) {
      categories = List<Categories>();
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = List<Images>();
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
  }
}

class Categories {
  int id;
  String name;
  Categories({this.id, this.name});
  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Images {
  String src;
  Images({this.src});
  Images.fromJson(Map<String, dynamic> json) {
    src = json['src'];
  }
}
