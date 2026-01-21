import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/Hmsilder.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<GoodDetailItem>_recommendList = [];

  SpecialRecommendResult _HotResult = SpecialRecommendResult(
    id: "", 
    title: "", 
    subTypes: []
  );

  SpecialRecommendResult _OneStopResult = SpecialRecommendResult(
    id: "", 
    title: "", 
    subTypes: []
  );

  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "", 
    title: "", 
    subTypes: []
  );
  List<CategoryItem> _categoryList = [];
  List<BannerItem> _bannerList = [];
  List<Widget> _getScrollChildren(){
    return [
      SliverToBoxAdapter(child: Hmsilder(bannerList: _bannerList),),
      SliverToBoxAdapter(child: SizedBox(height: 10),),
      SliverToBoxAdapter(child: Hmcategory(categoryList: _categoryList,),),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      SliverToBoxAdapter(child: Hmsuggestion(specialRecommendResult: _specialRecommendResult,),),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      SliverToBoxAdapter(child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(child: Hmhot(result: _HotResult, type: "hot",),),
          SizedBox(width: 10,),
          Expanded(child: Hmhot(result: _OneStopResult, type: "stop",),)
        ],
      )),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),
      Hmmorelist(RecommendList: _recommendList,),
    ];
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _getBannerList();
      _getCategoryList();
      _getGoodsList();
      _getHotList();
      _getOneStopList();
      _getRecommendList();
    }
    void _getBannerList()async{
      _bannerList = await getBannerListApi();
      setState(() {});
    }
    void _getCategoryList()async{
      _categoryList = await getCategoryListApi();
      setState(() {});
    }
    void _getGoodsList()async{
      _specialRecommendResult = await getGoodListApi();
      setState(() {});
    }
    void _getHotList()async{
      _HotResult = await getHotListApi();
      setState(() {});
    }

    void _getOneStopList()async{
      _OneStopResult = await getOneStopListApi();
      setState(() {});
    }
    void _getRecommendList()async{
      _recommendList = await getRecommendListApi({"limit":100});
      setState(() {});
    }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren(),);
  }
}