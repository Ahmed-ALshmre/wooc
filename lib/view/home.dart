import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wecc/controllwe/Catogre.dart';
import 'package:wecc/controllwe/getx.dart';
import 'package:wecc/key.dart';
import 'package:wecc/model/model.dart';
import 'package:wecc/tools/class.dart';
import 'package:wecc/view/widget/appbar.dart';
import 'package:wecc/view/widget/catogre.dart';
import 'package:woocommerce/woocommerce.dart';
import '../main.dart';
import 'ifo_products.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final ProductController productController = Get.put(ProductController());
  GetGatogre gatogre;
  List<WooProductCategory> catog = [];
  List<WooProduct> search = [];
  List<WooProduct> products = [];
  bool isLoding = false;
  void catogewPalgen() async {
    try {
      catog = await wooCommerce.getProductCategories();
      search = await wooCommerce.getProducts(
          search: 'SMOBY – MICKEY MM GARNISHED BUCKET');
      print("this is data for search $search");
      if (catog.isNotEmpty) {
        print(catog);
        setState(() {
          isLoding = true;
        });
      }
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    Fut.shera();
    catogewPalgen();
    // TODO: implement initState
    super.initState();
    test();
  }

  void test() async {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 250,
            child: isLoding
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final prod = catog[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CatogryW(
                                              id: prod.id,
                                              title: prod.name,
                                            )));
                              },
                              child: Container(
                                height: 160,
                                alignment: Alignment.center,
                                width: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey,
                                    image: DecorationImage(
                                        image: NetworkImage(prod.image == null
                                            ? ''
                                            : prod.image.src.toString()),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              prod.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: catog.length,
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
                  ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                'Activity toys',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              height: 300,
              child: FutureBuilder(
                future: GetGatogre.getCatog(61),
                builder: (context, AsyncSnapshot<List<Product>> productes) {
                  if (productes.hasData) {
                    return testNi(productes.data);
                  } else {
                    return Center(
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
                },
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                '4-8 years',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 290,
              child: FutureBuilder(
                future: GetGatogre.getCatog(72),
                builder: (context, AsyncSnapshot<List<Product>> productes) {
                  if (productes.hasData) {
                    return testNi(productes.data);
                  } else {
                    return Center(
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
                },
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                '0-3 years',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 290,
              child: FutureBuilder(
                future: GetGatogre.getCatog(71),
                builder: (context, AsyncSnapshot<List<Product>> productes) {
                  if (productes.hasData) {
                    return testNi(productes.data);
                  } else {
                    return Center(
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
                },
              )),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget testNi(List<Product> items) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            width: 180,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductInfo(
                                  product: items[index],
                                )));
                  },
                  child: Container(
                    height: 100,
                    width: 130,
                    child: Image.network(items[index].images[0].src),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    items[index].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text("(${items[index].rating_count.toString()})"),
                  ],
                ),
                Text(
                  "د.أ ${items[index].price}",
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          );
        });
  }
}
