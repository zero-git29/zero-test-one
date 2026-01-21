import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmmorelist extends StatefulWidget {
  final List<GoodDetailItem> RecommendList;
  const Hmmorelist({super.key , required this.RecommendList});

  @override
  State<Hmmorelist> createState() => _HmmorelistState();
}

class _HmmorelistState extends State<Hmmorelist> {
  Widget _getChildren(int index){
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                widget.RecommendList[index].picture,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                  width: 80,
                  height: 100,
                  color: Colors.black,
                );
                },
              ),
            ),
          ),
          SizedBox(height: 4,),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: Text(
              widget.RecommendList[index].name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black , fontSize: 20),
            ),
          ),
          SizedBox(height: 6,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "￥${widget.RecommendList[index].price}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    children: [
                      TextSpan(text: " "),
                      TextSpan(
                        text: "${widget.RecommendList[index].price}",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12,
                        )
                      )
                    ]
                  )
                ),
                Text(
                  "${widget.RecommendList[index].payCount}人付款",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.75
      ), 
    itemBuilder: (BuildContext context , int index){
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: _getChildren(index),
      );
    });
  }
}