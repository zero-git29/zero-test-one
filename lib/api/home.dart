import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListApi() async{
  return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((item){
    return BannerItem.formJSON(item as Map<String , dynamic>);
  }).toList();
}


Future<List<CategoryItem>> getCategoryListApi() async{
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((item){
    return CategoryItem.formJSON(item as Map<String , dynamic>);
  }).toList();
}



Future<SpecialRecommendResult> getGoodListApi() async{
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.GOODS_LIST)
  );
}