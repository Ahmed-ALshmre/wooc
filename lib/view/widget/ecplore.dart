import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../main.dart';
import '../ifo_products.dart';
import 'exploreinfo.dart';

class Exolore extends StatefulWidget {
  Exolore({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ExoloreState createState() => _ExoloreState();
}

class _ExoloreState extends State<Exolore> {
  List<WooProduct> products = [];
  List<WooProduct> featuredProducts = [];
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    isDebug: true,
  );
  getProducts() async {
    products = await wooCommerce.getProducts();
    setState(() {});
    print(products.toString());
  }

  @override
  void initState() {
    super.initState();
    //You would want to use a feature builder instead.
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 12) / 2;
    final double itemWidth = size.width / 2;
    return products.isNotEmpty
        ? CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final product = products[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExploerInfo(
                                          productInfo: products[index],
                                        )));
                          },
                          child: Container(
                            height: 230,
                            width: 200,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Image.network(
                              product.images[0].src,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: 200,
                            child: Text(
                              product.name ?? 'Loading...',
                              style:TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                              )
                            )),
                        SizedBox(height: 10,),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('د.أ ' + product.price ?? '',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17)))
                      ],
                    );
                  },
                  childCount: products.length,
                ),
              )
            ],
          )
        : Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SpinKitWanderingCubes(color: Colors.black),
              const SpinKitWanderingCubes(
                  color: Colors.blue, shape: BoxShape.circle),
            ],
          ),
        );
  }
}
