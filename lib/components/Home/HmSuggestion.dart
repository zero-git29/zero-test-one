import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmsuggestion extends StatefulWidget {
  final SpecialRecommendResult specialRecommendResult;
  const Hmsuggestion({super.key , required this.specialRecommendResult});

  @override
  State<Hmsuggestion> createState() => _HmsuggestionState();
}

class _HmsuggestionState extends State<Hmsuggestion> {

  List<GoodsItem> _getDisplayItem(){
    if (widget.specialRecommendResult.subTypes.isEmpty) return[];
    return widget.specialRecommendResult.subTypes.first.goodsItems.items.take(3).toList();
  }

  Widget _buildHeader(){
    return Row(
      children: [
        Text("特惠推荐",style: TextStyle(color: const Color.fromARGB(255, 86, 24, 20) , fontSize: 18 , fontWeight: FontWeight.w700),),
        SizedBox(width: 10,),
        Text("精选攻略",style: TextStyle(fontSize: 12 , color: const Color.fromARGB(255, 124, 63, 58),),),
      ],
    );
  }
  Widget _buildLeft(){
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
    );
  }
  List<Widget> _getChildrenList (){
    List<GoodsItem> list = _getDisplayItem();
    return List.generate(list.length, (int index) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 140,
                  color: Colors.black,
                );
              },
              list[index].picture , 
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10,),
          Container(
            child: Text("￥${list[index].price}" , style: TextStyle(color: Colors.white),),
            decoration: BoxDecoration(color: const Color.fromARGB(255, 240, 96, 12) , borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 4),
          )
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(12),
      color: Colors.blue,
      alignment: Alignment.center,
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 10,),
          Row(
            children: [
              _buildLeft(),
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