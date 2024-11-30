import 'package:flutter/material.dart';
import 'package:untitled/model/product.dart';
import 'package:untitled/model/user.dart';
import 'package:untitled/screen/authen/authenticate.dart';
import 'package:untitled/screen/home/home.dart';
import 'package:provider/provider.dart';

import 'detail_update/detail.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  

  @override
  Widget build(BuildContext context) {
    final customUser = Provider.of<CustomUser?>(context);

    // if(customUser == null){
    //   return Authenticate();
    // }
    // else {
    //   return Home();
    // }
    return ProductDetailScreen();






  }
}
