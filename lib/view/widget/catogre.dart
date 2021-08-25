import 'package:flutter/material.dart';
import 'package:wecc/controllwe/Catogre.dart';
import 'package:wecc/model/model.dart';
import 'package:wecc/view/ifo_products.dart';

class CatogryW extends StatefulWidget {
  final int id;
  final String title;
  const CatogryW({Key key, this.id, this.title}) : super(key: key);
  @override
  _CatogryWState createState() => _CatogryWState();
}
class _CatogryWState extends State<CatogryW> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 12) / 2;
    final double itemWidth = size.width / 2;
    print("id${widget.id}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 30,color: Colors.black,),
        onPressed: ()=>Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "${widget.title}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: Container(
          child: FutureBuilder(
            future: GetGatogre.getCatog(widget.id),
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
    );
  }

  Widget testNi(List<Product> items, double itemWidth, itemHeight) {
    return CustomScrollView(
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
            },
            childCount: items.length,
          ),
        )
      ],
    );
  }
}
