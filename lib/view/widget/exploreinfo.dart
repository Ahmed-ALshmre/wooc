import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_math/flutter_math.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecc/controllwe/provider.dart';
import 'package:woocommerce/models/products.dart';

import '../ifo_products.dart';

List<String> count = [];
List<String> idList = [];
List<String> name = [];
List<String> image = [];

class ExploerInfo extends StatefulWidget {
  final WooProduct productInfo;
  ExploerInfo({Key key, this.productInfo}) : super(key: key);

  @override
  _ExploerInfoState createState() => _ExploerInfoState();
}

class _ExploerInfoState extends State<ExploerInfo> {
  @override
  void initState() {
    convert();
    // TODO: implement initState
    super.initState();
  }

  void increment() {
    setState(() {
      x++;
    });
  }

  bool isLoading = true;

  String convert() {
    print("widget.productInfo${widget.productInfo}");
    String str = "${widget.productInfo.shortDescription.toString().trim()}";
    String tow = str.replaceAll("</p>", "");
    return tow.replaceAll("<p>", "");
  }

  int x = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: LikeButton(
              size: 30,
              circleColor:
                  CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite_border,
                  color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                  size: 40,
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.center,
                height: 250,
                width: double.infinity,
                color: Colors.black,
                child: ListView.builder(
                    itemCount: widget.productInfo.images.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 230,
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          widget.productInfo.images[index].src,
                        ),
                      );
                    })),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${widget.productInfo.name}',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerRight,
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.teal,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          x++;
                          Provider.of<ProviderClass>(context, listen: false)
                              .cartNumber(x);
                        },
                        child: Icon(Icons.add)),
                    Text(
                      context.watch<ProviderClass>().counter.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () {
                          if (x <= 0) {
                          } else {
                            x--;
                            Provider.of<ProviderClass>(context, listen: false)
                                .cartNumber(x);
                          }
                        },
                        child: Icon(Icons.remove)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'د.أ ${widget.productInfo.price}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 30,
                ),
                Text('(${widget.productInfo.ratingCount})'),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Html(
                data: widget.productInfo.shortDescription.trim(),
                customRender: {
                  "tex": (_, __, ___, element) => Math.tex(
                        element.text,
                        onErrorFallback: (FlutterMathException e) {
                          //return your error widget here e.g.
                          return Text(e.message);
                        },
                      ),
                }),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () async {

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      isLoading = false;
                    });
                    productList.add({
                      'name':widget.productInfo.name,
                      'image':widget.productInfo.images[0].src,
                      'count':x.toInt(),
                      'id':widget.productInfo.id.toInt(),
                    });
                    await  prefs.setStringList('id', prefs.getStringList('id'));
                    await  prefs.setStringList('name', prefs.getStringList('name'));
                    await   prefs.setStringList('image', prefs.getStringList('image'));
                    await prefs.setStringList('count', prefs.getStringList('count'));
                    setState(() {
                      isLoading = true;
                    });
                    Fluttertoast.showToast(
                        msg: "The product has been added to the cart",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isLoading
                        ? const Text(
                            'ADD TO CART',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        : const SpinKitWanderingCubes(color: Colors.black),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
