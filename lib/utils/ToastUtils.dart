import 'package:flutter/material.dart';

class Toastutils {
  static void showToast(BuildContext context , String? msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg ?? "加载成功" , textAlign: TextAlign.center,),
        duration: Duration(seconds: 5),
        width: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        behavior: SnackBarBehavior.floating,
      ));
  }
}