import 'package:flutter/material.dart';
import 'package:untitled/core/app_export.dart';
import 'package:untitled/services/Database/cart_service.dart';
import 'package:untitled/widgets/custom_elevated_button.dart';

import '../../model/Cart/cart_item.dart';
import '../../model/product.dart';

class CartScreen extends StatefulWidget {
  // const CartScreen({super.key, required this.product});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Product product;
  late CartService cartService;
  late AuthService authService;
  var userId = AuthService().getCurrentUser()!.uid;
  late Future<List<CartItem>> _listCartItems;


  @override
  void initState() {

    super.initState();
    cartService = CartService();
    authService = AuthService();
    _listCartItems = cartService.getCartItems(userId);
    // userId = authService.getCurrentUser()!.uid;
    // _getCartItems();
  }

  Future<List<CartItem>> _getCartItems() async {
    try {
      // return cartService.getCartItems(AuthService().getCurrentUser()!.uid);

     return cartService.getCartItems(userId);
    } on Exception catch (e) {
      throw (e);
    }
  }

  // Tính tổng số tiền của giỏ hàng
  Future<double> _calculateTotalPrice(Future<List<CartItem>> futureCartItems) async {
    final cartItems = await futureCartItems;
    double total = 0.0;
    for (var item in cartItems) {
      if (item.isSelect == true) {
        total += item.price * item.quantity;
      }
    }
    return total;
  }
  void _updateQuantity(CartItem item, int newQuantity) async {
    if (newQuantity < 1) return; // Ngăn không cho số lượng nhỏ hơn 1
    setState(() {
      item.quantity = newQuantity;
    });

    // Cập nhật số lượng lên Firestore
    await cartService.updateCartItemQuantity(userId, item.productId, newQuantity);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            setState(() {

            });
            Navigator.pushNamed(context, AppRoutes.homeScreen);
          },
        ),
        title: FutureBuilder<List<CartItem>>(
          future: _listCartItems, // Future danh sách giỏ hàng
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('CART (Loading...)');
            } else if (snapshot.hasError) {
              return Text('Error');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('CART (Empty)');
            }
            return Text('CART (${snapshot.data!.length})');
          },
        ),
        backgroundColor: LightCodeColors().deepPurpleA200,
      ),
      body: FutureBuilder<List<CartItem>>(
        future: _listCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading cart items.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Your cart is empty.'));
          }

          final items = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Checkbox
                            Checkbox(
                              value: item.isSelect,
                              onChanged: (val) {
                                print(' isSelect = ${item.isSelect}');
                                print(' val = ${val}');
                                setState(() {
                                  item.isSelect = val ?? false;
                                  print(' isSelect = ${item.isSelect}');
                                  print(' val = ${val}');
                                });
                              },
                            ),

                            Image.network(
                              item.imageUrl,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.productName,
                                    style: CustomTextStyles.titleProductBlack
                                        .copyWith(fontSize: 14.h),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                  ),


                                  Row(
                                    children: [
                                      Text(
                                        '\$${item.price}',
                                        style: CustomTextStyles.titleSmallPrimary,
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: item.quantity > 1
                                            ? () {
                                          _updateQuantity(item,
                                              item.quantity - 1);
                                        }
                                            : null,
                                      ),
                                      Text('${item.quantity}'),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          _updateQuantity(item, item.quantity + 1);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Tổng tiền
              FutureBuilder<double>(
                future: _calculateTotalPrice(_listCartItems),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Center(child: Text('Error calculating total price.')),
                    );
                  }

                  final totalPrice = snapshot.data!;
                  return Container(
                    height: 120.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total: \$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý thanh toán
                          },
                          child: Text(
                            'Buy',
                            style: CustomTextStyles.titleProductBlack
                                .copyWith(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(200, 60)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
