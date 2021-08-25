import 'package:flutter/material.dart';
import 'package:wecc/controllwe/Catogre.dart';
import 'package:wecc/model/model.dart';
import 'package:wecc/tools/class.dart';
import 'package:wecc/view/ifo_products.dart';

class Search extends StatefulWidget {
  const Search({Key key,}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool check = true;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 12) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(),
                    ),
                    child: TextField(
                      controller: controller,
                      onChanged: (c) {
                        Fut.search(c);
                        setState(() {
                          check = false;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      child: FutureBuilder(
                        future: Fut.search(controller.text.trim()),
                        builder: (context, AsyncSnapshot<List<Product>> model) {
                          if (model.hasData) {
                            print("data");
                            return testNi(model.data, itemWidth, itemHeight);
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )),
                ],
              ),
            )
    );
  }

  Widget testNi(List<Product> items, double itemWidth, itemHeight) {
   print("items.length${items.length}");
    return Container(
      height: 400,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context , index){
        final product = items[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                height: 230,
                width: 200,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                child: Text(product.name ?? 'Loading...',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('د.أ ' + product.price ?? '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)))
          ],
        );
      }),
    );
  }
}
