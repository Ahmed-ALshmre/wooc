import 'dart:convert';
import 'package:woocommerce/woocommerce.dart';
import 'package:http/http.dart' as http;

WooCommerce get woocommerce => WooCommerce(
    baseUrl: 'https://toyzeetoys.com/wp-json/wc/v3/products/',
    consumerKey: 'ck_981649ec00c094997c8c3a3ef7572f1eca5b9132',
    consumerSecret: 'cs_3866e2581fd47da5106e266a40afd0f05aad6b6a');

class GetDa {
  static String url =
      "https://toyzeetoys.com/wp-json/wc/v3/products/?consumer_key=ck_981649ec00c094997c8c3a3ef7572f1eca5b9132&consumer_secret=cs_3866e2581fd47da5106e266a40afd0f05aad6b6a&categories";
  static Future<void> getData() async {
    var res = await http.get(url);
    final data = json.decode(res.body);
    print(res.statusCode);
    print( "this is all tag product $data then here");
    print( "this is all tag product  then here");
  }
}