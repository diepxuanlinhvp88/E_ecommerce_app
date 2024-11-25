import 'dart:async';

import 'package:untitled/core/app_export.dart';
import 'package:untitled/model/Product.dart';
import 'package:untitled/services/product_service.dart';
import '../../../model/Product.dart';
import 'banner_list_item_model.dart';
import 'category_list_item_model.dart';

class HomeScreenModel {
  List<BannerListItemModel> bannerList = [
    BannerListItemModel(image: "lib/assets/images/banner1.png"),
    BannerListItemModel(image: "lib/assets/images/banner2.png"),
  ];

  Future<List<Product>> getTrendingProductList() async {
    Future<List<Product>> jsonProducts = ProductService().loadProductsFromJson();
    final productList = await jsonProducts;
    return productList.take(20).toList();
  }


  Future<List<Product>> getSaleProductList() async {
    Future<List<Product>> jsonProducts = ProductService().loadProductsFromJson();
    final productList = await jsonProducts;
    return productList.take(5).toList();
  }

  Future<List<Product>> recommendedProductList() async{
    Future<List<Product>> jsonProducts = ProductService().loadProductsFromJson();
    final productList = await jsonProducts;
    return productList.take(6).toList();
  }

  List<CategoryListItemModel> categoryList = [
    CategoryListItemModel(
        name: "Computer & Accessories",
        imageUrl: "lib/assets/icons/computer_and_accessories.svg"),
    CategoryListItemModel(
        name: "Home & Kitchen",
        imageUrl: "lib/assets/icons/home_and_kitchen.svg"),
    CategoryListItemModel(
        name: "Fashion & Apparel",
        imageUrl: "lib/assets/icons/fashion_and_apparel.svg"),
    CategoryListItemModel(
        name: "Groceries", imageUrl: "lib/assets/icons/groceries.svg"),
    CategoryListItemModel(name: "Toys", imageUrl: "lib/assets/icons/toys.svg"),
    CategoryListItemModel(
        name: "Books & Media",
        imageUrl: "lib/assets/icons/books_and_media.svg"),
  ];
}
