import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wecc/model/model.dart';

class GetGatogre {
  static String categories = 'categories';
  static Future<List<Product>> getCatog(int id) async {
    String url =
        "https://toyzeetoys.com/wp-json/wc/v3/products?category=$id&consumer_key=ck_981649ec00c094997c8c3a3ef7572f1eca5b9132&consumer_secret=cs_3866e2581fd47da5106e266a40afd0f05aad6b6a";
    List<Product> data = List<Product>();
    try {
      var getCato = await http.get(url);
      var _data = json.decode(getCato.body);
      print(" catof $_data");
      if (getCato.statusCode == 200) {
        print("data.length $_data");
        return List<Product>.from(json
            .decode(getCato.body.toString())
            .map((x) => Product.fromJson(x)));
      } else {
        return null;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<List<Product>> getProductId(
      List<int> id) async {
    String url =
        "https://toyzeetoys.com/wp-json/wc/v3/products?consumer_key=ck_981649ec00c094997c8c3a3ef7572f1eca5b9132&consumer_secret=cs_3866e2581fd47da5106e266a40afd0f05aad6b6a&include=${id.removeLast()}";
    List<Product> data = List<Product>();
    try {
      var getCato = await http.get(url);
      var _data = json.decode(getCato.body);
      print(" catof $_data");
      if (getCato.statusCode == 200) {
        print("data.length $_data");
        return List<Product>.from(json
            .decode(getCato.body.toString())
            .map((x) => Product.fromJson(x)));
      } else {
        return null;
      }
    } catch (e) {
      return e;
    }
  }
}
