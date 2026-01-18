import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String , String>> _tabList = [
    {
      "icon":"lib/assets/首页.png",
      "activeicon":"lib/assets/首页-选中.png",
      "text":"首页",
    },
    {
      "icon":"lib/assets/分类.png",
      "activeicon":"lib/assets/分类选中.png",
      "text":"分类",
    },
    {
      "icon":"lib/assets/购物车.png",
      "activeicon":"lib/assets/购物车选中.png",
      "text":"购物车",
    },
    {
      "icon":"lib/assets/我的.png",
      "activeicon":"lib/assets/我的选中.png",
      "text":"我的",
    },

  ];

  List<BottomNavigationBarItem> _getTabBarWidget(){
    return List.generate(_tabList.length, (int index){
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]! , width: 30,height: 30,) ,
        activeIcon: Image.asset(_tabList[index]["activeicon"]! ,width: 30,height: 30,),
        label: _tabList[index]["text"],
        );
    });
  }

  int _currentIndex = 0;

  List<Widget> _getChildren(){
    return[HomeView() , CategoryView() , CartView() , MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      IndexedStack(
        index: _currentIndex,
        children: _getChildren(),
      )
      ),
      bottomNavigationBar: 
      BottomNavigationBar(
        items: _getTabBarWidget(),
        currentIndex: _currentIndex,
        onTap: (int index){
          _currentIndex = index;
          setState(() {});
        },
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        ),
    );
  }
}