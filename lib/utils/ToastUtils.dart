import 'package:flutter/material.dart';

class Toastutils {
  static bool showLoading = false;
  static void showToast(BuildContext context , String? msg){
    if(Toastutils.showLoading){
      return;
    }
    Toastutils.showLoading = true;
    Future.delayed(Duration(seconds: 3),(){
      Toastutils.showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg ?? "加载成功" , textAlign: TextAlign.center,),
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        behavior: SnackBarBehavior.floating,
        width: MediaQuery.of(context).size.width * 0.6,
        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
      ));
  }
}