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
    CategoryListItemModel(
      name: "Computer & Accessories",
      imageUrl: "lib/assets/icons/computer_and_accessories.svg"
    ),
    CategoryListItemModel(
      name: "Home & Kitchen",
      imageUrl: "lib/assets/icons/home_and_kitchen.svg"
    ),
    CategoryListItemModel(
        name: "Fashion & Apparel",
        imageUrl: "lib/assets/icons/fashion_and_apparel.svg"
    ),
    CategoryListItemModel(
        name: "Groceries",
        imageUrl: "lib/assets/icons/groceries.svg"
    ),
    CategoryListItemModel(
        name: "Toys",
        imageUrl: "lib/assets/icons/toys.svg"
    ),
    CategoryListItemModel(
        name: "Books & Media",
        imageUrl: "lib/assets/icons/books_and_media.svg"
    ),
  ];
}