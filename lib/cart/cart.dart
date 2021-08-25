import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecc/controllwe/Catogre.dart';
import 'package:wecc/model/model.dart';
import 'package:wecc/view/check_out.dart';
import 'package:wecc/view/widget/exploreinfo.dart';
import 'package:wecc/view/ifo_products.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<int> newConut;
  // void shear() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     dataListAsInt = prefs.getStringList('id').map((data) => int.parse(data)).toList();
  //     count = prefs.getStringList('count').map((data) => int.parse(data)).toList();
  //     name =  prefs.getStringList('name');
  //     images =  prefs.getStringList('image');
  //   });
  // }

  @override
  void initState() {
    newConut = count.map((e) => int.parse(e)).toList();
    //   shear();
    // TODO: implement initState
    super.initState();
  }

  num cust = 0;
  int getTotal() {
    newConut.forEach((num e) {
      cust += e;
      return cust;
    });
  }

  @override
  Widget build(BuildContext context) {
    return productList.isNotEmpty
        ? Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 490,
                child: testNi(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 60,
                    width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOut()));
                      },
                      child: Text(
                        'Check Out',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Center(
            child: Text('There are no products'),
          );
  }

  Widget testNi() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${productList[index]['name']}"),
            //   subtitle: Text(" د.أ ${[index].price}"),
            trailing: InkWell(
                onTap: () {
                  setState(() {
                    productList.removeAt(index);
                  });
                },
                child: Icon(Icons.clear)),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(productList[index]['image']),
            ),
          );
        });
  }
}
