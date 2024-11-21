import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/app_export.dart';
import '../models/category_list_item_model.dart';

class CategoryListItemWidget extends StatelessWidget {
  final CategoryListItemModel categoryListItemObj;

  const CategoryListItemWidget(this.categoryListItemObj, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategoryItem(
          icon: Icons.computer,
          label: categoryListItemObj.computer!,
          width: 40.h,
        ),
        _buildCategoryItem(
          icon: Icons.chair,
          label: categoryListItemObj.homekitchen!,
          width: 40.h,
        ),
        _buildCategoryItem(
          icon: Icons.checkroom,
          label: categoryListItemObj.fashionapparel!,
          width: 40.h,
        ),
        _buildLastSection(),
      ],
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required String label,
    required double width,
  }) {
    return SizedBox(
      width: 60.h,
      child: Column(
        children: [
          Container(
            height: 40.h,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 4.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              border: Border.all(
                color: appTheme.blueGray100,
                width: 0.5.h,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 10.h,
              fontWeight: FontWeight.w500,
            )
          ),
        ],
      ),
    );
  }

  Widget _buildLastSection() {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 124.h,
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCartContainer(),
                  _buildCircularContainer(),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            _buildCategoriesText(),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContainer() {
    return Container(
      height: 40.h,
      width: 40.h,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.blueGray100,
          width: 0.5.h,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.shopping_cart_sharp)
        ],
      ),
    );
  }

  Widget _buildCircularContainer() {
    return Container(
      height: 40.h,
      width: 40.h,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(6.h),
        border: Border.all(
          color: appTheme.blueGray100,
          width: 0.5.h,
        ),
      ),
    );
  }

  Widget _buildCategoriesText() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            categoryListItemObj.groceries!,
            style: theme.textTheme.labelSmall?.copyWith(fontSize: 8.h),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.h),
            child: Text(
              categoryListItemObj.toys!,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(fontSize: 8.h),
            ),
          ),
        ],
      ),
    );
  }
}