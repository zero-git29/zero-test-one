import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/Hmsilder.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int _page = 1; //页码
  bool _isLoading = false; //正在加载与否
  bool _haveMore = true; //还有页面与否

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
      //普通做法（无开局下拉刷新）
      // _getBannerList();
      // _getCategoryList();
      // _getGoodsList();
      // _getHotList();
      // _getOneStopList();
      // _getRecommendList();
      _registerEvent();
      Future.microtask((){
        _paddingTop = 100;
        setState(() {});
        _key.currentState?.show();//执行下拉刷新
        });
    }


    Future<void> _onRefresh()async{
      _page = 1;
      _isLoading = false;
      _haveMore = true;
      await _getBannerList();
      await _getCategoryList();
      await _getGoodsList();
      await _getHotList();
      await _getOneStopList();
      await _getRecommendList();
      
      Toastutils.showToast(context, "刷新成功");
      _paddingTop = 0;
      setState(() {});
    }

    //监听滚动到底部时间
    void _registerEvent() {
      _controller.addListener((){
        if (_controller.position.pixels >= (_controller.position.maxScrollExtent - 50))
        {
          _getRecommendList();
        }
      });
    }

    Future<void> _getBannerList()async{
      _bannerList = await getBannerListApi();
      setState(() {});
    }
    Future<void> _getCategoryList()async{
      _categoryList = await getCategoryListApi();
      setState(() {});
    }
    Future<void> _getGoodsList()async{
      _specialRecommendResult = await getGoodListApi();
      setState(() {});
    }
    Future<void> _getHotList()async{
      _HotResult = await getHotListApi();
      setState(() {});
    }
    Future<void> _getOneStopList()async{
      _OneStopResult = await getOneStopListApi();
      setState(() {});
    }
    Future<void> _getRecommendList()async{
      if(_isLoading || !_haveMore){
        return;
      }
      _isLoading = true;
      int requestLimit = _page * 10;
      _recommendList = await getRecommendListApi({"limit":requestLimit});
      _isLoading = false;
      setState(() {});
      if (_recommendList.length < requestLimit)
      {
        _haveMore = false;
        return;
      }
      _page++;
    }


  final ScrollController _controller = ScrollController();
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          slivers: _getScrollChildren(),
          controller: _controller,
    ),
    ) 
    );
  }
}