
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class Dielo{
  static void  secc(context){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'succeeded',
      desc: 'Your order has been successfully sent Payment on delivery',
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
    )..show();
  }
}