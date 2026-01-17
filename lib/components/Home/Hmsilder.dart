import 'package:flutter/material.dart';

class Hmsilder extends StatefulWidget {
  const Hmsilder({super.key});

  @override
  State<Hmsilder> createState() => _HmsilderState();
}

class _HmsilderState extends State<Hmsilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text("轮播图" , style: TextStyle(color: Colors.white , fontSize: 20),),
    );
  }
}