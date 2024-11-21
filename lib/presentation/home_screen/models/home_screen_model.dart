import 'package:untitled/core/app_export.dart';
import 'package:untitled/model/Product.dart';
import '../../../model/Product.dart';
import 'banner_list_item_model.dart';
import 'category_list_item_model.dart';

class HomeScreenModel {
  List<BannerListItemModel> bannerList = [
    BannerListItemModel(image: "lib/assets/images/banner1.png"),
    BannerListItemModel(image: "lib/assets/images/banner2.png"),
  ];

  List<Product> trendingProductList = [
    products[0],
    products[0],
    products[0],
    products[0],
    products[0],
  ];

  List<Product> saleProductList = [
    products[0],
    products[0],
    products[0],
    products[0],
    products[0],
  ];

  List<Product> recommendedProductList = [
    products[0],
    products[0],
    products[0],
    products[0],
    products[0],
    products[0],
    products[0],
    products[0],
  ];

  List<CategoryListItemModel> categoryList = [
    CategoryListItemModel(),
    CategoryListItemModel(),
  ];
}