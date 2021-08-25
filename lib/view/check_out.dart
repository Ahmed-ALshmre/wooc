import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wecc/tools/class.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/models/order_payload.dart';
import 'ifo_products.dart';

class CheckOut extends StatefulWidget {
  final List<Map> myList;
  const CheckOut({Key key, this.myList}) : super(key: key);
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController _emilController = TextEditingController();
  TextEditingController _pasController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    _phoneController.text = "United Arab Emirates";
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _cityController.dispose();
    _streetController.dispose();
    _pasController.dispose();
    _nameController.dispose();
    _emilController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Billing details',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              textFiled('Email', _emilController),
              SizedBox(
                height: 10,
              ),
              textFiled('Full Name', _nameController),
              SizedBox(
                height: 10,
              ),
              textFiled('COUNTRY / REGION *', _pasController),
              SizedBox(
                height: 10,
              ),
              textFiled('STREET ADDRESS *', _streetController),
              SizedBox(
                height: 10,
              ),
              textFiled('TOWN / CITY *', _cityController),
              SizedBox(
                height: 10,
              ),
              textFiled('PHONE *', _phoneController),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  List<Map> map = [];
                  if (_cityController.text.isNotEmpty &&
                      _nameController.text.isNotEmpty &&
                      _emilController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      _pasController.text.isNotEmpty &&
                      _streetController.text.isNotEmpty) {
                    for(var i in  productList){
                      print("for loop $i");
                      map.add({
                        'product_id':i['id'],
                        'quantity':i['count'].toString(),
                      });
                    }
                    Fut.setDataAndLogin(
                      streat: _streetController.text,
                     city: _cityController.text,
                      phone: _phoneController.text,
                      context: context,
                      email: _emilController.text,
                      product: map,
                      users: _nameController.text,
                      pass: _pasController.text,


                    ).then((value) {
                      _phoneController.clear();
                      _nameController.clear();
                      _emilController.clear();
                      _pasController.clear();
                    });
                  } else {

                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal,
                  ),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFiled(String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.teal),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
