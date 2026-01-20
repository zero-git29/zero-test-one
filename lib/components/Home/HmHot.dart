import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmhot extends StatefulWidget {
  final SpecialRecommendResult result;
  final String type;
  const Hmhot({super.key , required this.result , required this.type});

  @override
  State<Hmhot> createState() => _HmhotState();
}

class _HmhotState extends State<Hmhot> {
  List<GoodsItem> get _items{
    if (widget.result.subTypes.isEmpty) return[];
    return widget.result.subTypes.first.goodsItems.items.take(2).toList();
  }

  Widget _buildHeader(){
    return Row(
      children: [
        Text(
          widget.type == "stop" ? "一站买全" : "爆款推荐",
          style: TextStyle(color: const Color.fromARGB(255, 86, 24, 20) , fontSize: 18 , fontWeight: FontWeight.w700),
        ),
        SizedBox(width: 10,),
        Text(
          widget.type == "stop" ? "精心优选" : "最受欢迎",
          style: TextStyle(fontSize: 12 , color: const Color.fromARGB(255, 124, 63, 58),),
        ),
      ],
    );
  }


  List<Widget> _getChildrenList (){
    return _items.map((item)
    {
      return Container(
        width: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 140,
                  color: Colors.black,
                );
              },
              item.picture , 
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            ),
            ),
            SizedBox(height: 10,),
            Container(
            child: Text("￥${item.price}" , style: TextStyle(color: Colors.black , fontSize: 12),),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 4),
          )
          ],
        ) ,
      );
    }).toList();
}



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.type == "stop" ? 
        const Color.fromARGB(255, 249, 247, 219):
        const Color.fromARGB(255, 211, 228, 240),
        borderRadius: BorderRadius.circular(12)
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _getChildrenList(),
              ))
            ],
          )
        ],
      )
    );
  }
}