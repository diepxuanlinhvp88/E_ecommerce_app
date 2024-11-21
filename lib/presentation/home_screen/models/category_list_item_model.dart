import 'package:untitled/core/app_export.dart';

class CategoryListItemModel {

  CategoryListItemModel(
    {this.computer,
    this.homekitchen,
    this.fashionapparel,
    this.groceries,
    this.toys,
    this.id}) {
    computer = computer ?? "Computer & Accessories";
    homekitchen = homekitchen ?? "Home & Kitchen";
    fashionapparel = fashionapparel ?? " Fashion & Apparel";
    groceries = groceries ?? "Groceries";
    toys = toys ?? "Toys";
    id = id ?? "";
  }

  String? computer;
  String? homekitchen;
  String? fashionapparel;
  String? groceries;
  String? toys;
  String? id;
}