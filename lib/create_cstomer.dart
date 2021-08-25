import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import 'main.dart';

class CreateUsers extends StatefulWidget {
   CreateUsers({Key key}) : super(key: key);

  @override
  _CreateUsersState createState() => _CreateUsersState();
}

class _CreateUsersState extends State<CreateUsers> {
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    isDebug: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: InkWell(
              onTap: ()async{
                WooOrderPayload orderPayload = WooOrderPayload(customerId: 24,setPaid: true);
                final myCart = await wooCommerce.createOrder(orderPayload);
                print(myCart);
              },
              child: Text('create'),
            ),
          )
        ],
      ),
    );
  }
}