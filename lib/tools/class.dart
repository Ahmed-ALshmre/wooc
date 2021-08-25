import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecc/key.dart';
import 'package:wecc/model/model.dart';
import 'package:wecc/view/home.dart';
import 'package:wecc/view/ifo_products.dart';
import 'package:wecc/view/widget/dilog.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/models/order_payload.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class Fut {
  static Future<void> shera() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('id', []);
    await prefs.setStringList('name', []);
    await prefs.setStringList('image', []);
    await prefs.setStringList('count', []);
  }

  static Future<void> setDataAndLogin({
    String streat,
    context,
    List<Map> product,
    String users,
    email,
    city,
    phone,
    pass,
  }) async {
    EasyLoading.show(status: 'loading...');
    String url =
        "https://toyzeetoys.com/wp-json/wc/v3/orders?consumer_key=ck_981649ec00c094997c8c3a3ef7572f1eca5b9132&consumer_secret=cs_3866e2581fd47da5106e266a40afd0f05aad6b6a";
    print(product);
    try {
      var response = await Dio().post(url, data: {
        "payment_method": "cash",
        "payment_method_title": "cash",
        "set_paid": 'true',
        "billing": {
          "first_name": users.toString(),
          "last_name": "",
          "address_1": "$streat",
          "address_2": "",
          "city": city,
          "state": "CA",
          "postcode": "",
          "country": pass,
          "email": "$email",
          "phone": "$phone"
        },
        "shipping": {
          "first_name": "$users",
          "last_name": "",
          "address_1": "$streat",
          "address_2": "",
          "city": "$city",
          "state": "CA",
          "postcode": "",
          "country": "$pass"
        },
        "line_items": product,
      });
      EasyLoading.dismiss();
      Dielo.secc(context);
      productList.clear();
      product.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));

      print(response);
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Product>> search(String word) async {
    String url =
        "https://toyzeetoys.com/wp-json/wc/v3/products?consumer_key=ck_981649ec00c094997c8c3a3ef7572f1eca5b9132&consumer_secret=cs_3866e2581fd47da5106e266a40afd0f05aad6b6a&search=$word";
    try {
      var response = await Dio().get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return List<Product>.from(json
            .decode(response.data.toString())
            .map((x) => Product.fromJson(x)));
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
